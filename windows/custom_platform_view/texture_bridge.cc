#include "texture_bridge.h"

#include <windows.foundation.h>

#include <algorithm>
#include <atomic>
#include <cassert>
#include <iostream>

#include "util/direct3d11.interop.h"

namespace aqutter_core_plugin
{
  // Two buffers, not one. With a single buffer the pool hands the very same surface to the next
  // capture as soon as OnFrameArrived releases its frame, while |last_frame_| is still being read
  // later on Flutter's raster thread (copy / map in GetSurfaceDescriptor / CopyPixelBuffer). A
  // second buffer lets the capture rotate away from the surface that is being read.
  const int kNumBuffers = 2;

  TextureBridge::TextureBridge(GraphicsContext* graphics_context,
    ABI::Windows::UI::Composition::IVisual* visual)
    : graphics_context_(graphics_context)
  {
    visual_.copy_from(visual);
    const bool attached = AttachCaptureItem();
    assert(attached);
    (void)attached;
  }

  bool TextureBridge::AttachCaptureItem()
  {
    if (capture_item_ && on_closed_token_.value != 0) {
      capture_item_->remove_Closed(on_closed_token_);
      on_closed_token_ = {};
    }
    capture_item_ =
      graphics_context_->CreateGraphicsCaptureItemFromVisual(visual_.get());
    if (!capture_item_) {
      return false;
    }

    capture_item_->add_Closed(
      Microsoft::WRL::Callback<ABI::Windows::Foundation::ITypedEventHandler<
      ABI::Windows::Graphics::Capture::GraphicsCaptureItem*,
      IInspectable*>>(
        [this](ABI::Windows::Graphics::Capture::IGraphicsCaptureItem* item,
          IInspectable* args) -> HRESULT
        {
          // Only record it. The capture stops delivering frames, and the next Start() (every
          // setSize call goes through it) tears the session down and builds a new one.
          capture_closed_ = true;
          return S_OK;
        })
      .Get(),
          &on_closed_token_);
    return true;
  }

  TextureBridge::~TextureBridge()
  {
    const std::lock_guard<std::mutex> lock(mutex_);
    StopInternal();
    if (capture_item_ && on_closed_token_.value != 0) {
      capture_item_->remove_Closed(on_closed_token_);
    }
  }

  bool TextureBridge::Start()
  {
    const std::lock_guard<std::mutex> lock(mutex_);
    if (capture_closed_.exchange(false)) {
      StopInternal();
      if (!AttachCaptureItem()) {
        return false;
      }
    }
    if (is_running_ || !capture_item_) {
      return false;
    }

    ABI::Windows::Graphics::SizeInt32 size;
    capture_item_->get_Size(&size);

    frame_pool_ = graphics_context_->CreateCaptureFramePool(
      graphics_context_->device(),
      static_cast<ABI::Windows::Graphics::DirectX::DirectXPixelFormat>(
        kPixelFormat),
      kNumBuffers, size);
    if (!frame_pool_) {
      std::cerr << "Creating capture frame pool failed." << std::endl;
      return false;
    }

    frame_pool_->add_FrameArrived(
      Microsoft::WRL::Callback<ABI::Windows::Foundation::ITypedEventHandler<
      ABI::Windows::Graphics::Capture::Direct3D11CaptureFramePool*,
      IInspectable*>>(
        [this](ABI::Windows::Graphics::Capture::IDirect3D11CaptureFramePool*
          pool,
          IInspectable* args) -> HRESULT
        {
          OnFrameArrived();
          return S_OK;
        })
      .Get(),
          &on_frame_arrived_token_);

    if (FAILED(frame_pool_->CreateCaptureSession(capture_item_.get(),
      capture_session_.put()))) {
      std::cerr << "Creating capture session failed." << std::endl;
      AbortStart();
      return false;
    }

    if (SUCCEEDED(capture_session_->StartCapture())) {
      is_running_ = true;
      return true;
    }

    AbortStart();
    return false;
  }

  void TextureBridge::AbortStart()
  {
    if (frame_pool_) {
      frame_pool_->remove_FrameArrived(on_frame_arrived_token_);
      on_frame_arrived_token_ = {};
      frame_pool_ = nullptr;
    }
    capture_session_ = nullptr;
  }

  void TextureBridge::Stop()
  {
    const std::lock_guard<std::mutex> lock(mutex_);
    StopInternal();
  }

  void TextureBridge::StopInternal()
  {
    if (is_running_) {
      is_running_ = false;
      frame_pool_->remove_FrameArrived(on_frame_arrived_token_);
      auto closable =
        capture_session_.try_as<ABI::Windows::Foundation::IClosable>();
      assert(closable);
      closable->Close();
      capture_session_ = nullptr;
    }
  }

  void TextureBridge::OnFrameArrived()
  {
    const std::lock_guard<std::mutex> lock(mutex_);
    if (!is_running_) {
      return;
    }

    bool has_frame = false;

    winrt::com_ptr<ABI::Windows::Graphics::Capture::IDirect3D11CaptureFrame>
      frame;
    auto hr = frame_pool_->TryGetNextFrame(frame.put());
    if (SUCCEEDED(hr) && frame) {
      winrt::com_ptr<
        ABI::Windows::Graphics::DirectX::Direct3D11::IDirect3DSurface>
        frame_surface;

      if (SUCCEEDED(frame->get_Surface(frame_surface.put()))) {
        last_frame_ =
          TryGetDXGIInterfaceFromObject<ID3D11Texture2D>(frame_surface);
        // Set even for a dropped frame: the fps limit governs how often Flutter is *notified*,
        // and a drop must not leave the newest content unpresented when Flutter composites
        // anyway for some other reason.
        has_pending_frame_ = true;
        has_frame = !ShouldDropFrame();
      }
    }

    if (needs_update_) {
      ABI::Windows::Graphics::SizeInt32 size;
      capture_item_->get_Size(&size);
      frame_pool_->Recreate(
        graphics_context_->device(),
        static_cast<ABI::Windows::Graphics::DirectX::DirectXPixelFormat>(
          kPixelFormat),
        kNumBuffers, size);
      needs_update_ = false;
    }

    if (has_frame && frame_available_) {
      frame_available_();
    }
  }

  bool TextureBridge::ShouldDropFrame()
  {
    if (!frame_duration_.has_value()) {
      return false;
    }
    auto now = std::chrono::high_resolution_clock::now();

    bool should_drop_frame = false;
    if (last_frame_timestamp_.has_value()) {
      auto diff = std::chrono::duration_cast<std::chrono::milliseconds>(
        now - last_frame_timestamp_.value());
      should_drop_frame = diff < frame_duration_.value();
    }

    if (!should_drop_frame) {
      last_frame_timestamp_ = now;
    }
    return should_drop_frame;
  }

  void TextureBridge::NotifySurfaceSizeChanged()
  {
    const std::lock_guard<std::mutex> lock(mutex_);
    needs_update_ = true;
  }

  void TextureBridge::SetFpsLimit(std::optional<int> max_fps)
  {
    const std::lock_guard<std::mutex> lock(mutex_);
    auto value = max_fps.value_or(0);
    if (value != 0) {
      frame_duration_ = FrameDuration(1000.0 / value);
    }
    else {
      frame_duration_.reset();
      last_frame_timestamp_.reset();
    }
  }
}
import Flutter
import UIKit

/// iOS 原生擷取（native view 鏡像用）。
///
/// PlatformView（如 `GMSMapView`）是 UIKit 疊合的原生 view，不進 Flutter 可 rasterize 的場景，
/// `RenderRepaintBoundary.toImage` 抓不到。這裡改用 OS 級的 `drawHierarchy(afterScreenUpdates:)`，
/// 回傳 straight RGBA bytes，走與 Flutter 擷取相同的 WebSocket 管線。
///
/// MethodChannel：`com.github.aqutter/nativeview`，method `capture`，
/// args `{x, y, w, h, viewTypeContains?}`（logical points，Flutter 全域座標），
/// 回傳 `{width, height, bytes}`。
public class AqutterNativeCapture: NSObject {
  public static let channelName = "com.github.aqutter/nativeview"

  /// 擷取解析度上限（倍率）；降到 2× 換 fps（螢幕原生可能是 3×）。
  private static let captureScale: CGFloat = 2.0

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: channelName, binaryMessenger: registrar.messenger())
    let handler = AqutterNativeCapture()
    channel.setMethodCallHandler { call, result in
      handler.handle(call, result: result)
    }
  }

  private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard call.method == "capture",
      let args = call.arguments as? [String: Any],
      let x = args["x"] as? Double, let y = args["y"] as? Double,
      let w = args["w"] as? Double, let h = args["h"] as? Double
    else {
      result(FlutterMethodNotImplemented)
      return
    }
    let typeName = args["viewTypeContains"] as? String
    DispatchQueue.main.async {
      result(self.capture(x: x, y: y, w: w, h: h, viewTypeContains: typeName))
    }
  }

  private func keyWindow() -> UIWindow? {
    return UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first { $0.isKeyWindow }
  }

  private func capture(x: Double, y: Double, w: Double, h: Double, viewTypeContains: String?) -> Any? {
    guard let window = keyWindow() else { return nil }
    let scale = min(AqutterNativeCapture.captureScale, window.screen.scale)
    let format = UIGraphicsImageRendererFormat()
    format.scale = scale
    format.opaque = false

    // 優先：直接擷取目標 view 本身——只含該 view、排除疊在其上的不透明網頁覆蓋層，
    // 因此滿版鏡像頁（網頁完全蓋住原生 view）也取得到，且免裁切。
    if let typeName = viewTypeContains,
      let target = firstView(in: window, typeContaining: typeName),
      target.bounds.width >= 1, target.bounds.height >= 1 {
      let bounds = target.bounds
      let image = UIGraphicsImageRenderer(bounds: bounds, format: format).image { _ in
        target.drawHierarchy(in: bounds, afterScreenUpdates: true)
      }
      if let cg = image.cgImage, let out = rgba(from: cg) { return out }
    }

    // 後備：整個 window 快照再裁切到傳入的 rect（原生 view 未被遮蔽時）。
    let full = UIGraphicsImageRenderer(bounds: window.bounds, format: format).image { _ in
      window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
    }
    guard let cg = full.cgImage else { return nil }
    let pixelRect = CGRect(x: x * scale, y: y * scale, width: w * scale, height: h * scale)
      .intersection(CGRect(x: 0, y: 0, width: cg.width, height: cg.height))
    guard !pixelRect.isNull, pixelRect.width >= 1, pixelRect.height >= 1,
      let cropped = cg.cropping(to: pixelRect) else { return nil }
    return rgba(from: cropped)
  }

  /// 遞迴找類名含 [typeContaining] 的 view（以類名比對，免 import 該 view 所屬的 SDK）。
  private func firstView(in view: UIView, typeContaining name: String) -> UIView? {
    if String(describing: type(of: view)).contains(name) { return view }
    for subview in view.subviews {
      if let found = firstView(in: subview, typeContaining: name) { return found }
    }
    return nil
  }

  /// CGImage → straight RGBA bytes。
  private func rgba(from image: CGImage) -> Any? {
    let width = image.width
    let height = image.height
    var data = Data(count: width * height * 4)
    let drawn: Bool = data.withUnsafeMutableBytes { raw in
      guard let base = raw.baseAddress,
        let context = CGContext(
          data: base, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4,
          space: CGColorSpaceCreateDeviceRGB(),
          bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
      else { return false }
      context.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
      return true
    }
    guard drawn else { return nil }
    return [
      "width": width,
      "height": height,
      "bytes": FlutterStandardTypedData(bytes: data),
    ]
  }
}

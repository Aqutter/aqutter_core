import Flutter
import UIKit

/// 穿透模式下，把「原生觸控區域」內的觸控直接交給底下的原生 view（地圖），其他點照原路徑走。
///
/// Flutter 的 platform view 外面都有一層 `FlutterTouchInterceptingView`，穿透時上層的 WebView 會把整個範圍的觸控吃掉；
/// 這個透明 view 蓋在 window 最上層，只在區域內回傳底下的 view，其他點回 `nil`（不參與）。
final class NativeTouchRouter: UIView {
  static let channelName = "aqutter_core/native_touch"
  static let shared = NativeTouchRouter(frame: .zero)

  /// 目前存活的 `AqutterWebView`（弱參考）；hit test 時要暫時略過它們外面的 platform view 容器。
  let webViews = NSHashTable<UIView>.weakObjects()
  private var regions: [CGRect] = []

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .clear
    autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: channelName, binaryMessenger: registrar.messenger())
    channel.setMethodCallHandler { call, result in
      guard call.method == "setRegions", let list = call.arguments as? [[Double]] else {
        result(FlutterMethodNotImplemented)
        return
      }
      shared.setRegions(list.compactMap { $0.count == 4 ? CGRect(x: $0[0], y: $0[1], width: $0[2], height: $0[3]) : nil })
      result(nil)
    }
  }

  private func setRegions(_ next: [CGRect]) {
    regions = next
    attachIfNeeded()
  }

  private func attachIfNeeded() {
    guard superview == nil, !regions.isEmpty else { return }
    let window = UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first { $0.isKeyWindow }
    guard let window else { return }
    frame = window.bounds
    window.addSubview(self)
  }

  /// WebView 外面那層 Flutter 的 platform view 容器：最外層的 `ChildClippingView`（沒有就退回 `FlutterTouchInterceptingView`）。
  /// 只關掉攔截那層不夠，外面的裁切容器是整個畫面大小，仍會把觸控吃掉。
  private static func interceptor(of view: UIView) -> UIView? {
    var outermost: UIView?
    var current: UIView? = view
    while let candidate = current {
      let name = String(describing: type(of: candidate))
      if name == "ChildClippingView" || (name == "FlutterTouchInterceptingView" && outermost == nil) {
        outermost = candidate
      }
      current = candidate.superview
    }
    return outermost
  }

  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    guard !regions.isEmpty, regions.contains(where: { $0.contains(point) }),
      let window, let root = window.rootViewController?.view
    else {
      return nil
    }
    let covered = webViews.allObjects.compactMap { Self.interceptor(of: $0) }.filter { $0.isUserInteractionEnabled }
    covered.forEach { $0.isUserInteractionEnabled = false }
    isUserInteractionEnabled = false
    defer {
      isUserInteractionEnabled = true
      covered.forEach { $0.isUserInteractionEnabled = true }
    }
    guard let hit = root.hitTest(root.convert(point, from: self), with: event),
      hit !== root, String(describing: type(of: hit)) != "FlutterView"
    else {
      return nil
    }
    return hit
  }
}

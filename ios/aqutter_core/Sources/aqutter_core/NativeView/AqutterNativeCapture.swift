import Flutter
import UIKit

/// iOS 原生擷取（native view 鏡像用）。
///
/// PlatformView（如 `GMSMapView`）是 UIKit 疊合的原生 view，不進 Flutter 可 rasterize 的場景，
/// `RenderRepaintBoundary.toImage` 抓不到。這裡改用 OS 級的 `drawHierarchy(afterScreenUpdates:)`，
/// 回傳 straight RGBA bytes，走與 Flutter 擷取相同的 WebSocket 管線。
///
/// MethodChannel：`com.github.aqutter/nativeview`，method `capture`，
/// args `{x, y, w, h, viewTypeContains?, pixelRatio?, skipUnchanged?}`（logical points，Flutter 全域座標），
/// 回傳 `{width, height, bytes}`；`skipUnchanged` 為 true 且畫面與上一張完全相同時回 `{unchanged: true}`（不回像素）。
public class AqutterNativeCapture: NSObject {
  public static let channelName = "com.github.aqutter/nativeview"

  /// 擷取解析度上限（倍率）；降到 2× 換 fps（螢幕原生可能是 3×）。
  private static let captureScale: CGFloat = 2.0

  /// 各擷取區域上一張回傳的像素，供 skipUnchanged 比對（同尺寸才比）；以區域左上角分開，同頁多個地圖才不會互相比對。
  private var lastByRegion: [String: (data: Data, size: (Int, Int))] = [:]
  /// 最近一次擷取各階段耗時（毫秒），隨結果回傳給 Dart 方便量測。
  private var timing: [String: Double] = [:]
  private func now() -> Double { return CACurrentMediaTime() * 1000 }

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
    let pixelRatio = args["pixelRatio"] as? Double
    let skipUnchanged = args["skipUnchanged"] as? Bool ?? false
    let jpegQuality = args["jpegQuality"] as? Double
    DispatchQueue.main.async {
      result(self.capture(x: x, y: y, w: w, h: h, viewTypeContains: typeName, pixelRatio: pixelRatio, skipUnchanged: skipUnchanged, jpegQuality: jpegQuality))
    }
  }

  private func keyWindow() -> UIWindow? {
    return UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first { $0.isKeyWindow }
  }

  private func capture(x: Double, y: Double, w: Double, h: Double, viewTypeContains: String?, pixelRatio: Double?, skipUnchanged: Bool, jpegQuality: Double?) -> Any? {
    guard let window = keyWindow() else { return nil }
    // 解析度：呼叫端給了 pixelRatio（網頁實際需要的、或自適應降下來的）就用它，上限仍是 2× 與螢幕倍率
    let scale = min(CGFloat(pixelRatio ?? Double(AqutterNativeCapture.captureScale)), AqutterNativeCapture.captureScale, window.screen.scale)
    let format = UIGraphicsImageRendererFormat()
    format.scale = scale
    format.opaque = false

    // 優先：直接擷取目標 view 本身——只含該 view、排除疊在其上的不透明網頁覆蓋層，
    // 因此滿版鏡像頁（網頁完全蓋住原生 view）也取得到，且免裁切。
    if let typeName = viewTypeContains,
      let target = bestView(in: window, typeContaining: typeName, overlapping: CGRect(x: x, y: y, width: w, height: h)),
      target.bounds.width >= 1, target.bounds.height >= 1 {
      let bounds = target.bounds
      // 直接畫進自己的 RGBA 緩衝：省掉「renderer 出 CGImage 再重畫一次」的整張複製
      let drawStart = now()
      if let direct = renderDirect(view: target, bounds: bounds, scale: scale) {
        timing = ["draw": now() - drawStart]
        return emit(width: direct.width, height: direct.height, data: direct.data, regionKey: "\(Int(x.rounded())),\(Int(y.rounded()))", skipUnchanged: skipUnchanged, jpegQuality: jpegQuality)
      }
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

  private func renderDirect(view: UIView, bounds: CGRect, scale: CGFloat) -> (width: Int, height: Int, data: Data)? {
    let width = Int((bounds.width * scale).rounded())
    let height = Int((bounds.height * scale).rounded())
    guard width >= 1, height >= 1 else { return nil }
    var data = Data(count: width * height * 4)
    let drawn: Bool = data.withUnsafeMutableBytes { raw in
      guard let base = raw.baseAddress,
        let context = CGContext(
          data: base, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4,
          space: CGColorSpaceCreateDeviceRGB(),
          bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
      else { return false }
      // UIKit 座標原點在左上：翻轉後再縮放到目標解析度
      context.translateBy(x: 0, y: CGFloat(height))
      context.scaleBy(x: scale, y: -scale)
      UIGraphicsPushContext(context)
      let ok = view.drawHierarchy(in: bounds, afterScreenUpdates: true)
      UIGraphicsPopContext()
      return ok
    }
    return drawn ? (width, height, data) : nil
  }

  private func emit(width: Int, height: Int, data: Data, regionKey: String, skipUnchanged: Bool, jpegQuality: Double?) -> Any? {
    let compareStart = now()
    if skipUnchanged, let last = lastByRegion[regionKey], last.size == (width, height), last.data == data {
      timing["compare"] = now() - compareStart
      return ["unchanged": true, "timing": timing]
    }
    timing["compare"] = now() - compareStart
    if lastByRegion.count >= 8, lastByRegion[regionKey] == nil { lastByRegion.removeAll() }
    lastByRegion[regionKey] = (data, (width, height))
    // 有給品質就壓成 JPEG：移動中的畫面每幀小一個數量級，傳輸與網頁端解碼都省
    let encodeStart = now()
    if let quality = jpegQuality, let jpeg = jpegData(width: width, height: height, data: data, quality: quality) {
      timing["encode"] = now() - encodeStart
      return [
        "timing": timing,
        "width": width,
        "height": height,
        "format": "jpeg",
        "bytes": FlutterStandardTypedData(bytes: jpeg),
      ]
    }
    return [
      "timing": timing,
      "width": width,
      "height": height,
      "bytes": FlutterStandardTypedData(bytes: data),
    ]
  }

  private func jpegData(width: Int, height: Int, data: Data, quality: Double) -> Data? {
    guard let provider = CGDataProvider(data: data as CFData),
      let image = CGImage(
        width: width, height: height, bitsPerComponent: 8, bitsPerPixel: 32, bytesPerRow: width * 4,
        space: CGColorSpaceCreateDeviceRGB(),
        bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipLast.rawValue),
        provider: provider, decode: nil, shouldInterpolate: false, intent: .defaultIntent)
    else { return nil }
    return UIImage(cgImage: image).jpegData(compressionQuality: CGFloat(quality))
  }

  /// 類名含 [typeContaining] 的 view 裡，與 [rect]（視窗座標，logical points）重疊面積最大的那個。
  /// 同一頁有多個同類的 view（例如兩個地圖左右各一半）時，才不會每個鏡像都擷取到第一個。
  private func bestView(in window: UIWindow, typeContaining name: String, overlapping rect: CGRect) -> UIView? {
    var matches: [UIView] = []
    collectViews(in: window, typeContaining: name, into: &matches)
    var best: UIView?
    var bestArea: CGFloat = -1
    for view in matches {
      let frame = view.convert(view.bounds, to: window)
      let overlap = frame.intersection(rect)
      let area = overlap.isNull ? 0 : overlap.width * overlap.height
      if area > bestArea {
        best = view
        bestArea = area
      }
    }
    return best
  }

  private func collectViews(in view: UIView, typeContaining name: String, into result: inout [UIView]) {
    if String(describing: type(of: view)).contains(name) { result.append(view) }
    for subview in view.subviews {
      collectViews(in: subview, typeContaining: name, into: &result)
    }
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

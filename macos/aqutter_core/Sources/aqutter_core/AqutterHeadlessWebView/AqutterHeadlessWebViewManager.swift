//
//  AqutterHeadlessWebViewManager.swift
//  aqutter_core
//
//  Created by Lorenzo Pichilli on 10/05/2020.
//

import Foundation

import FlutterMacOS
import AppKit
import WebKit
import Foundation
import AVFoundation

public class AqutterHeadlessWebViewManager: ChannelDelegate {
    static let METHOD_CHANNEL_NAME = "com.github.aqutter/headless_webview"
    var plugin: AqutterCorePlugin?
    var webViews: [String: AqutterHeadlessWebView?] = [:]
    
    init(plugin: AqutterCorePlugin) {
        super.init(channel: FlutterMethodChannel(name: AqutterHeadlessWebViewManager.METHOD_CHANNEL_NAME, binaryMessenger: plugin.registrar.messenger))
        self.plugin = plugin
    }
    
    public override func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        let id: String = arguments!["id"] as! String

        switch call.method {
            case "run":
                let params = arguments!["params"] as! [String: Any?]
                run(id: id, params: params)
                result(true)
                break
            default:
                result(FlutterMethodNotImplemented)
                break
        }
    }
    
    public func run(id: String, params: [String: Any?]) {
        guard let plugin = plugin else {
            return
        }
        let flutterWebView = FlutterWebViewController(plugin: plugin,
            withFrame: CGRect.zero,
            viewIdentifier: id,
            params: params as NSDictionary)
        let headlessAqutterWebView = AqutterHeadlessWebView(plugin: plugin, id: id, flutterWebView: flutterWebView)
        webViews[id] = headlessAqutterWebView
        
        headlessAqutterWebView.prepare(params: params as NSDictionary)
        headlessAqutterWebView.onWebViewCreated()
        flutterWebView.makeInitialLoad(params: params as NSDictionary)
    }
    
    public override func dispose() {
        super.dispose()
        let headlessWebViews = webViews.values
        headlessWebViews.forEach { (headlessWebView: AqutterHeadlessWebView?) in
            headlessWebView?.dispose()
        }
        webViews.removeAll()
        plugin = nil
    }
    
    deinit {
        dispose()
    }
}

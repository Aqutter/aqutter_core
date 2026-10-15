//
//  WebViewTransport.swift
//  aqutter_core
//
//  Created by Lorenzo Pichilli on 16/02/21.
//

import Foundation

public class WebViewTransport: NSObject {
    var webView: AqutterWebView
    var request: URLRequest
    
    init(webView: AqutterWebView, request: URLRequest) {
        self.webView = webView
        self.request = request
    }
}

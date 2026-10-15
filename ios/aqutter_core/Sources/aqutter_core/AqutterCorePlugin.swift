/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at
 http://www.apache.org/licenses/LICENSE-2.0
 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

import Flutter
import UIKit
import WebKit
import Foundation
import AVFoundation
import SafariServices

public class AqutterCorePlugin: NSObject, FlutterPlugin {
    
    var registrar: FlutterPluginRegistrar
    var platformUtil: PlatformUtil?
    var aqutterWebViewManager: AqutterWebViewManager?
    var myCookieManager: Any?
    var myWebStorageManager: Any?
    var credentialDatabase: CredentialDatabase?
    var aqutterBrowserManager: AqutterBrowserManager?
    var headlessAqutterWebViewManager: AqutterHeadlessWebViewManager?
    var chromeSafariBrowserManager: ChromeSafariBrowserManager?
    var webAuthenticationSessionManager: WebAuthenticationSessionManager?
    var printJobManager: PrintJobManager?
    var proxyManager: Any?
    
    var webViewControllers: [String: AqutterBrowserWebViewController?] = [:]
    var safariViewControllers: [String: Any?] = [:]
    
    public init(with registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
        
        super.init()
        
        registrar.register(FlutterWebViewFactory(plugin: self) as FlutterPlatformViewFactory, withId: FlutterWebViewFactory.VIEW_TYPE_ID)
        
        platformUtil = PlatformUtil(plugin: self)
        aqutterBrowserManager = AqutterBrowserManager(plugin: self)
        headlessAqutterWebViewManager = AqutterHeadlessWebViewManager(plugin: self)
        chromeSafariBrowserManager = ChromeSafariBrowserManager(plugin: self)
        aqutterWebViewManager = AqutterWebViewManager(plugin: self)
        credentialDatabase = CredentialDatabase(plugin: self)
        if #available(iOS 11.0, *) {
            myCookieManager = MyCookieManager(plugin: self)
        }
        if #available(iOS 9.0, *) {
            myWebStorageManager = MyWebStorageManager(plugin: self)
        }
        webAuthenticationSessionManager = WebAuthenticationSessionManager(plugin: self)
        printJobManager = PrintJobManager(plugin: self)
        if #available(iOS 17.0, *) {
            proxyManager = ProxyManager(plugin: self)
        }
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let _ = AqutterCorePlugin(with: registrar)
    }
    
    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        platformUtil?.dispose()
        platformUtil = nil
        aqutterBrowserManager?.dispose()
        aqutterBrowserManager = nil
        headlessAqutterWebViewManager?.dispose()
        headlessAqutterWebViewManager = nil
        chromeSafariBrowserManager?.dispose()
        chromeSafariBrowserManager = nil
        aqutterWebViewManager?.dispose()
        aqutterWebViewManager = nil
        credentialDatabase?.dispose()
        credentialDatabase = nil
        if #available(iOS 11.0, *) {
            (myCookieManager as? MyCookieManager)?.dispose()
            myCookieManager = nil
        }
        if #available(iOS 9.0, *) {
            (myWebStorageManager as? MyWebStorageManager)?.dispose()
            myWebStorageManager = nil
        }
        webAuthenticationSessionManager?.dispose()
        webAuthenticationSessionManager = nil
        printJobManager?.dispose()
        printJobManager = nil
        if #available(iOS 17.0, *) {
            (proxyManager as? ProxyManager)?.dispose()
            proxyManager = nil
        }
    }
}

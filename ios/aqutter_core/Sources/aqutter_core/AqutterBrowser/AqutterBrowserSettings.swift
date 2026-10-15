//
//  AqutterBrowserOptions.swift
//  aqutter_core
//
//  Created by Lorenzo on 17/09/18.
//

import Foundation

@objcMembers
public class AqutterBrowserSettings: ISettings<AqutterBrowserWebViewController> {
    
    var hidden = false
    var hideToolbarTop = true
    var toolbarTopBackgroundColor: String?
    var hideUrlBar = false
    var hideProgressBar = false
    
    var toolbarTopTranslucent = true
    var toolbarTopBarTintColor: String?
    var toolbarTopTintColor: String?
    var hideToolbarBottom = true
    var toolbarBottomBackgroundColor: String?
    var toolbarBottomTintColor: String?
    var toolbarBottomTranslucent = true
    var closeButtonCaption: String?
    var closeButtonColor: String?
    var presentationStyle = 0 //fullscreen
    var transitionStyle = 0 //crossDissolve
    var hideCloseButton = false
    var menuButtonColor: String?
    
    override init(){
        super.init()
    }
    
    override func getRealSettings(obj: AqutterBrowserWebViewController?) -> [String: Any?] {
        var realOptions: [String: Any?] = toMap()
        if let aqutterBrowserWebViewController = obj {
            realOptions["hidden"] = aqutterBrowserWebViewController.isHidden
            realOptions["hideUrlBar"] = aqutterBrowserWebViewController.searchBar.isHidden
            realOptions["hideProgressBar"] = aqutterBrowserWebViewController.progressBar.isHidden
            realOptions["closeButtonCaption"] = aqutterBrowserWebViewController.closeButton.title
            realOptions["closeButtonColor"] = aqutterBrowserWebViewController.closeButton.tintColor?.hexString
            realOptions["menuButtonColor"] = aqutterBrowserWebViewController.menuButton?.tintColor?.hexString
            if let navController = aqutterBrowserWebViewController.navigationController {
                realOptions["hideToolbarTop"] = navController.navigationBar.isHidden
                realOptions["toolbarTopBackgroundColor"] = navController.navigationBar.backgroundColor?.hexString
                realOptions["toolbarTopTranslucent"] = navController.navigationBar.isTranslucent
                realOptions["toolbarTopBarTintColor"] = navController.navigationBar.barTintColor?.hexString
                realOptions["toolbarTopTintColor"] = navController.navigationBar.tintColor?.hexString
                realOptions["hideToolbarBottom"] = navController.toolbar.isHidden
                realOptions["toolbarBottomBackgroundColor"] = navController.toolbar.barTintColor?.hexString
                realOptions["toolbarBottomTranslucent"] = navController.toolbar.isTranslucent
                realOptions["toolbarBottomTintColor"] = navController.toolbar.tintColor?.hexString
                realOptions["presentationStyle"] = navController.modalPresentationStyle.rawValue
                realOptions["transitionStyle"] = navController.modalTransitionStyle.rawValue
            }
        }
        return realOptions
    }
}

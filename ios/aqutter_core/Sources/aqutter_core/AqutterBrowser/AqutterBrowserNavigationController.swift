//
//  AqutterBrowserNavigationController.swift
//  aqutter_core
//
//  Created by Lorenzo Pichilli on 14/02/21.
//

import Foundation
import UIKit

public class AqutterBrowserNavigationController: UINavigationController {
    deinit {
        debugPrint("AqutterBrowserNavigationController - dealloc")
        UIApplication.shared.delegate?.window??.makeKeyAndVisible()
    }
}

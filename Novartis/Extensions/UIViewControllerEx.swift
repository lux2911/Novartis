//
//  UIViewControllerEx.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func displayError(error: Error) {
        Helpers.ViewHelpers.showAlert(viewController: self, message: error.localizedDescription, title: "Error")
    }
}


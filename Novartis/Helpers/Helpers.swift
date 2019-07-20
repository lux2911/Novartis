//
//  Helpers.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import Foundation
import UIKit

enum Helpers {
    enum ViewHelpers {
                
        static func showAlert(viewController: UIViewController, message: String, title: String = "Alert" ) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
        
    }
}

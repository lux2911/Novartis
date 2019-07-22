//
//  UIApplicationEx.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/22/19.
//  Copyright © 2019 lux. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    public static var isRunningTest: Bool {
        return ProcessInfo().arguments.contains("testMode")
    }
}

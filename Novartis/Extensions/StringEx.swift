//
//  StringEx.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/21/19.
//  Copyright © 2019 lux. All rights reserved.
//

import Foundation

extension String {
    func titlecased() -> String {
        return self.replacingOccurrences(of: "([A-Z])", with: " $1", options: .regularExpression, range: self.range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
    }
}

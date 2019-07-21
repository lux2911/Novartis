//
//  CountryInfo.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import Foundation

struct CountryInfo: Codable {
    let area: Int
    let density: Double
    let population: Int
    let largestCity: String
    let capital: String
    let spokenLanguages: [String]
    let currency: String
    
    subscript(index: Int) -> (String, String) {
        let mirror = Mirror(reflecting: self)
        if index >= mirror.children.count { return ("","")}
        
        let idx = mirror.children.index(mirror.children.startIndex, offsetBy: index)
        let property = mirror.children[idx]
        let val = String(describing: property.value)
        return (property.label!, val)
    }
    
    subscript(name: String) -> (String, String) {
        let mirror = Mirror(reflecting: self)
        if let property = mirror.children.first(where: { (arg0) -> Bool in
            arg0.label! == name
        }) {
            let val = String(describing: property.value)
            return (property.label!, val)
        }
        return ("","")
    }
}

enum CountryField : String {
    case area
    case population
    case largestCity
    
    case spokenLanguages
    case currency
    
    case density
    case capital
}

enum Country {
    case ireland([CountryField])
    case germany([CountryField])
}


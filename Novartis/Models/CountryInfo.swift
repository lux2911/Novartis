//
//  CountryInfo.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import Foundation

struct CountryInfo: Codable, BaseCountryInfo {
    
    let area: Int
    let density: Double
    let population: Int
    let largestCity: String
    let capital: String
    let spokenLanguages: [String]
    let currency: String
    
}

protocol BaseCountryInfo {
    
    var area: Int { get }
    var population: Int { get }
    var largestCity: String { get }
}

protocol IrelandInfo: BaseCountryInfo {
    var spokenLanguages: [String] { get }
    var currency: String { get }
}

protocol GermanyInfo: BaseCountryInfo {
    var density: Double { get }
    var capital: String { get }
}


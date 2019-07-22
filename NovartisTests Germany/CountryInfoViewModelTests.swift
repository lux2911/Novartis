//
//  CountryInfoViewModelTests.swift
//  NovartisTests Germany
//
//  Created by Tomislav Luketic on 7/22/19.
//  Copyright © 2019 lux. All rights reserved.
//

import XCTest
@testable import Novartis_Germany

class CountryInfoViewModelTests: XCTestCase {

    let viewModel = CountryInfoViewModel()
    
    
    func testCountryInfoFields() {
        XCTAssertEqual(viewModel.countryFields, [.area, .population, .largestCity, .density, .capital])
    }
    
    func testCountryInfo() {
        viewModel.getCountryInfo()
        XCTAssertEqual(viewModel.countryInfo!.capital, "Berlin", "Capital should be 'Berlin'")
    }

}

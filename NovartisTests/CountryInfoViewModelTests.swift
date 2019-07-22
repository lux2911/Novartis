//
//  CountryInfoViewModelTests.swift
//  NovartisTests
//
//  Created by Tomislav Luketic on 7/22/19.
//  Copyright © 2019 lux. All rights reserved.
//

import XCTest
@testable import Novartis

class CountryInfoViewModelTests: XCTestCase {

    let viewModel = CountryInfoViewModel()
   

    func testCountryInfoFields() {
       XCTAssertEqual(viewModel.countryFields, [.area, .population, .largestCity, .spokenLanguages, .currency])
    }
    
    func testCountryInfo() {
       viewModel.getCountryInfo()
       XCTAssertEqual(viewModel.countryInfo!.capital, "Dublin", "Capital should be 'Dublin'")
    }

    

}

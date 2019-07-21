//
//  CountryInfoViewModel.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import Foundation

class CountryInfoViewModel {
    
    private (set) var countryInfo: CountryInfo? {
        didSet {
            reloadData?()
            print("DidSet")
        }
    }
    
    var reloadData: (()->Void)?
    var displayError: ((Error)->Void)?
    
    private var country : Country?
    var countryFields: [CountryField] {
        if let country = self.country {
            switch country {
                case .ireland(let properties), .germany(let properties):
                return properties
            }
        }
        return []
    }
    
    init() {
        initCountry()
    }
    
    private func initCountry() {
        switch RestClient.shared.countryId {
        case "GE":
            country = Country.germany([.area, .population, .largestCity, .density, .capital])
        default:
            country = Country.ireland([.area, .population, .largestCity, .spokenLanguages, .currency])
            
        }
    }
    
    func getCountryInfo() {
        
        RestClient.shared.getCountryInfo { result in
             if result.isSuccess {
                self.countryInfo = result.value
             } else {
                self.displayError?(result.error!)
             }
        }
        
    }
    
}

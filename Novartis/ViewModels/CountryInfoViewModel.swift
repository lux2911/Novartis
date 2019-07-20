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

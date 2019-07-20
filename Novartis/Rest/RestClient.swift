//
//  RestClient.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import Foundation
import Alamofire

typealias CountryInfoCompletionBlock = (Result<CountryInfo>) -> Void

protocol NovartisServiceProtocol {
   func getCountryInfo(_ completion: @escaping CountryInfoCompletionBlock)
   var countryId : String { get }
}

extension NovartisServiceProtocol {
    var countryId : String {
        get {
            #if IRELAND
            return "IR"
            #elseif GERMANY
            return "GE"
            #endif
        }
    }
}

class RestClient: NovartisServiceProtocol {
    
    static let shared: NovartisServiceProtocol = NSClassFromString("XCTest") == nil && !RestClient.useMockedData() ? RestClient() : MockRestClient()
    
    
    private init(){ }
    
    class func useMockedData() -> Bool {
        #if USE_MOCK_DATA
        return true
        #else
        return false
        #endif
    }
    
    func getCountryInfo(_ completion: @escaping CountryInfoCompletionBlock){
        
        Alamofire.request(ServiceRouter.countryInfo(countryCode: countryId))
            .response { response in
                guard let data = response.data, response.error == nil else {
                    completion(Result<CountryInfo>.failure(response.error!))
                    return
                }
                
                let countryInfo = try! JSONDecoder().decode(CountryInfo.self, from: data)
                completion(Result<CountryInfo>.success(countryInfo))
                
        }
    }
  
}
// Instance of this class will be instantiated when executing unit tests
class MockRestClient : NovartisServiceProtocol  {
    
    func getCountryInfo(_ completion: @escaping CountryInfoCompletionBlock){
        
        let data = try! Data.init(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: countryId, ofType: "json")!))
        let countryInfo = try! JSONDecoder().decode(CountryInfo.self, from: data)
        completion(Result<CountryInfo>.success(countryInfo))
    }
    
}


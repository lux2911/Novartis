//
//  RestClient.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

typealias CountryInfoCompletionBlock = (Result<CountryInfo>) -> Void
typealias RestLoginCompletionBlock = (Result<UserData>) -> Void
typealias RestNewUserCompletionBlock = (Result<NewUserResponseData>) -> Void

protocol NovartisServiceProtocol {
    func login(_ userName:String, pass:String, completion: @escaping RestLoginCompletionBlock)
    func login(with invitationCode: String, completion: @escaping RestLoginCompletionBlock)
    func getCountryInfo(_ completion: @escaping CountryInfoCompletionBlock)
    func newUser(_ newUserData: NewUserData, completion: @escaping RestNewUserCompletionBlock)
    
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
    
    func login(_ userName: String, pass: String, completion: @escaping RestLoginCompletionBlock) {
        Alamofire.request(ServiceRouter.login(userName: userName, pass: pass))
            .response { response in
                guard let data = response.data, response.error == nil else {
                    completion(Result<UserData>.failure(response.error!))
                    return
                }
                
                let userData = try! JSONDecoder().decode(UserData.self, from: data)
                completion(Result<UserData>.success(userData))
                
        }
    }
    
    func login(with invitationCode: String, completion: @escaping RestLoginCompletionBlock) {
        Alamofire.request(ServiceRouter.invitationLogin(code: invitationCode))
            .response { response in
                guard let data = response.data, response.error == nil else {
                    completion(Result<UserData>.failure(response.error!))
                    return
                }
                
                let userData = try! JSONDecoder().decode(UserData.self, from: data)
                completion(Result<UserData>.success(userData))
                
        }
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
    
    func newUser(_ newUserData: NewUserData, completion: @escaping RestNewUserCompletionBlock) {
        Alamofire.request(ServiceRouter.newUser(newUserData: newUserData))
            .response { response in
                guard let data = response.data, response.error == nil else {
                    completion(Result<NewUserResponseData>.failure(response.error!))
                    return
                }
                
                let newUser = try! JSONDecoder().decode(NewUserResponseData.self, from: data)
                completion(Result<NewUserResponseData>.success(newUser))
                
        }
    }
  
}
// Instance of this class will be instantiated when executing unit tests or USE_MOCK_DATA has been set
class MockRestClient : NovartisServiceProtocol  {
    
    func login(_ userName: String, pass: String, completion: @escaping RestLoginCompletionBlock) {
        completion(Result<UserData>.success(UserData(accessToken: "xxx")))
    }
    
    func login(with invitationCode: String, completion: @escaping RestLoginCompletionBlock) {
        completion(Result<UserData>.success(UserData(accessToken: "xxx")))
    }
    
    func getCountryInfo(_ completion: @escaping CountryInfoCompletionBlock){
        
        let data = try! Data.init(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: countryId, ofType: "json")!))
        let countryInfo = try! JSONDecoder().decode(CountryInfo.self, from: data)
        completion(Result<CountryInfo>.success(countryInfo))
    }
    
    func newUser(_ newUserData: NewUserData, completion: @escaping RestNewUserCompletionBlock) {
        completion(Result<NewUserResponseData>.success(NewUserResponseData(email: newUserData.email)))
    }
    
}


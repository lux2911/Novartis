//
//  LoginManager.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import Foundation
import Auth0

class UserData {
    
}

typealias LoginCompletionBlock = (Result<Credentials>) -> Void

protocol LoginProtocol {
    func login(userNameOrEmail: String, pass: String, completion:@escaping LoginCompletionBlock)
    func login(with invitationCode: String) -> Bool
    func newUser(credentials: UserData) -> Bool
    var credentials: Credentials? { get }
}
extension LoginProtocol {
    func login(with invitationCode: String) -> Bool {
        return false
    }
}

class LoginManager : LoginProtocol {
    
    
    
    var credentials: Credentials?
    
    static let shared : LoginProtocol = RestClient.shared.countryId == "IR" ? Auth0LoginManager() : LoginManager()
   
    
    private init() {}
    
    func login(userNameOrEmail: String, pass: String, completion: @escaping LoginCompletionBlock) {
        
    }
    
    func newUser(credentials: UserData) -> Bool {
        
        return false
    }
}

class Auth0LoginManager: LoginProtocol {
    var credentials: Credentials?
    
    func login(userNameOrEmail: String, pass: String, completion: @escaping LoginCompletionBlock) {
        
        Auth0
            .authentication()
            .login(
                usernameOrEmail: userNameOrEmail,
                password: pass,
                realm: "Username-Password-Authentication",
                scope: "openid profile")
            .start { result in
                DispatchQueue.main.async {
                    
                    switch result {
                    case .success(let credentials):
                        self.credentials = credentials
                        print(credentials.accessToken!)
                       
                        //self.loginWithCredentials(credentials)
                    case .failure(let error):
                       
                        print(error.localizedDescription)
                        // self.showAlertForError(error)
                    }
                    
                    completion(result)
                }
        }
        

    }
    
    func newUser(credentials: UserData) -> Bool {
        return false
    }
    
    
}

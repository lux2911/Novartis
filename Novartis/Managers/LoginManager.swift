//
//  LoginManager.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import Foundation
import Auth0

enum MustImplementFuncError : Error {
    case loginWithInvitationCode
}

struct UserData : Codable {
    let accessToken: String
}

struct NewUserData : Codable {
    let userNameOrEmail: String
    let pass: String
    let name: String
    let email: String
    let dob: String
    let country: String
}

struct NewUserResponseData : Codable {
    let email: String
}

typealias LoginCompletionBlock = (Result<UserData>) -> Void
typealias NewUserCompletionBlock = (Result<DatabaseUser>) -> Void

protocol LoginProtocol {
    func login(userNameOrEmail: String, pass: String, completion:@escaping LoginCompletionBlock)
    func login(with invitationCode: String, completion:@escaping LoginCompletionBlock) throws
    func newUser(newUserData: NewUserData, completion:@escaping NewUserCompletionBlock)
    
}
extension LoginProtocol {
    func login(with invitationCode: String, completion:@escaping LoginCompletionBlock) throws  {
        
        if !(self is LoginManager) {
            throw MustImplementFuncError.loginWithInvitationCode
        }
        
        RestClient.shared.login(with: invitationCode) { result in
            if result.isSuccess {
                LoginManager.userData = result.value!
                completion(Result<UserData>.success(result: result.value!))
            } else {
                completion(Result<UserData>.failure(error: result.error!))
            }
        }
    }
}

class LoginManager : LoginProtocol {
    
    static var credentials: Credentials? {
        didSet {
            guard let credentials = credentials else {
                _ = credentialsManager.clear()
                return
            }
            _ = credentialsManager.store(credentials: credentials)
            userData = UserData(accessToken: credentials.accessToken!)
        }
    }
    
    static var userData: UserData? {
        get {
            let defaults = UserDefaults.standard
            if let accessToken = defaults.string(forKey: "AccessToken") {
                return UserData(accessToken: accessToken)
            }
            return nil
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue?.accessToken, forKey: "AccessToken")
            defaults.synchronize()
        }
    }
    
    static let shared : LoginProtocol = RestClient.shared.countryId == "IR" ? Auth0LoginManager() : LoginManager()
    static let credentialsManager = CredentialsManager(authentication: Auth0.authentication())
    
    private init() { }
    
    func login(userNameOrEmail: String, pass: String, completion: @escaping LoginCompletionBlock) {
        RestClient.shared.login(userNameOrEmail, pass: pass) { result in
            if result.isSuccess {
                LoginManager.userData = result.value!
                completion(Result<UserData>.success(result: result.value!))
            } else {
                completion(Result<UserData>.failure(error: result.error!))
            }
        }
    }
    
    func newUser(newUserData: NewUserData, completion:@escaping NewUserCompletionBlock) {
        RestClient.shared.newUser(newUserData) { result in
            if result.isSuccess {
                let user : DatabaseUser = (email: result.value!.email, username: "", verified: true)
                completion(Result<DatabaseUser>.success(result: user))
            } else {
                completion(Result<DatabaseUser>.failure(error: result.error!))
            }
        }
    }
      
}

class Auth0LoginManager: LoginProtocol {
    
    
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
                        LoginManager.credentials = credentials
                        print(credentials.accessToken!)
                        completion(Result<UserData>.success(result: UserData(accessToken: credentials.accessToken!)))
                       
                    case .failure(let error):
                       
                        print(error.localizedDescription)
                        completion(Result<UserData>.failure(error: error))
                    }
                                        
                }
        }
     
    }
    
    func newUser(newUserData: NewUserData, completion:@escaping NewUserCompletionBlock) {
        Auth0
            .authentication()
            .createUser(
                email: newUserData.userNameOrEmail,
                password: newUserData.pass,
                connection: "Username-Password-Authentication",
                userMetadata: ["name": newUserData.name,
                               "email": newUserData.userNameOrEmail,
                               "dob": newUserData.dob,
                               "country": newUserData.country]
            )
            .start { result in
                DispatchQueue.main.async {
                   
                    switch result {
                    case .success(let user):
                        print(user.email)
                       
                    case .failure(let error):
                      
                        print(error.localizedDescription)
                    }
                    
                    completion(result)
                }
        }

    }
    
    
}

//
//  LoginManagerTests.swift
//  NovartisTests
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import XCTest
@testable import Novartis

class LoginManagerTests: XCTestCase {
    
    var loginManager: LoginProtocol = LoginManager.shared
       
    
    func test_login_succeeds() {
        let promise = expectation(description: "Result is success")
        
        loginManager.login(userNameOrEmail: "test", pass: "test") { (result) in
            switch result {
            case .success:
                promise.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        wait(for: [promise], timeout: 5)
    }
    
    func test_login_withCode_succeeds() {
        let promise = expectation(description: "Result is success")
        
        do {
            try loginManager.login(with: "Test") { (result) in
                switch result {
                case .success:
                    promise.fulfill()
                case .failure(let error):
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }
        } catch (let error) {
            XCTFail("Error: \(error.localizedDescription)")
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    func test_newUser_succeeds() {
        let promise = expectation(description: "Result is success")
        let userData = NewUserData(userNameOrEmail: "Test@test.com",
                                   pass: "TestPass!!!",
                                   name: "Testy",
                                   email: "Test@test.com",
                                   dob: "11/11/1111",
                                   country: "Ireland")
        loginManager.newUser(newUserData: userData) { (result) in
            switch result {
            case .success:
                promise.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        wait(for: [promise], timeout: 5)
    }
    
}

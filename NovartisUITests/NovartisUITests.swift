//
//  NovartisUITests.swift
//  NovartisUITests
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//

import XCTest

class NovartisUITests: XCTestCase {

    override func setUp() {
       
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchArguments = ["testMode"]
        app.launch()

    }
  

    func testLoginInit() {
        
        let app = XCUIApplication()
        
        XCTAssertTrue(app.otherElements["LoginView"].exists, "LoginViewController not displayed")
        XCTAssertFalse(app.buttons["Login"].isEnabled, "'Login' button shoud be disabled initially")
        XCTAssertFalse(app.buttons["New User"].isEnabled, "'New User' button shoud be disabled initially")
        
        let passField = app.otherElements["LoginView"].children(matching: .secureTextField).element
        XCTAssertTrue(passField.exists, "Text field for password should be secure")
      
        let sw = app.switches["PassSwitch"]
        let isOn = sw.value! as! String
        XCTAssertEqual(isOn, "0", "Switch should be off initially")
        
    }
    
    func testButtonsEnabled() {
        
        let app = XCUIApplication()
        app.textFields["Username"].typeText("lux@lux.com")
        let passField = app.otherElements["LoginView"].children(matching: .secureTextField).element
        passField.tap()
        passField.typeText("pass")
        
        XCTAssertTrue(app.buttons["Login"].isEnabled, "'Login' button shoud be enabled after username&pass are entered")
        XCTAssertTrue(app.buttons["New User"].isEnabled, "'New User' button shoud be enabled after username&pass are entered")
        
    }
    
    func testLoginWithValidCredentials(){
        let app = XCUIApplication()
        app.textFields["Username"].typeText("lookateach1@gmail.com")
        let passField = app.otherElements["LoginView"].children(matching: .secureTextField).element
        passField.tap()
        passField.typeText("Maherlux2704")
        app.buttons["Login"].tap()
        
        let countryInfoView = app.otherElements["CountryInfoView"]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: countryInfoView, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testLoginWithInvalidCredentials() {
        
        let app = XCUIApplication()
        app.textFields["Username"].typeText("xxx")
        let passField = app.otherElements["LoginView"].children(matching: .secureTextField).element
        passField.tap()
        passField.typeText("yyy")
        app.buttons["Login"].tap()
        
        let alert = app.alerts["Error"]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: alert, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
    }

}

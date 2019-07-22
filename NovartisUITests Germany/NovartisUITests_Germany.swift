//
//  NovartisUITests_Germany.swift
//  NovartisUITests Germany
//
//  Created by Tomislav Luketic on 7/22/19.
//  Copyright © 2019 lux. All rights reserved.
//

import XCTest

class NovartisUITests_Germany: XCTestCase {

    override func setUp() {
        
        let app = XCUIApplication()
        app.launchArguments = ["testMode"]
        app.launch()
    }


    func testLoginInit() {
        let app = XCUIApplication()
        
        XCTAssertTrue(app.otherElements["InvitationLogin"].exists, "InvitationCodeLoginViewController not displayed")
        XCTAssertFalse(app.buttons["Senden"].isEnabled, "'Senden' button shoud be disabled initially")
        
        let sw = app.switches["TermsSwitch"]
        let isOn = sw.value! as! String
        XCTAssertEqual(isOn, "0", "Switch should be off initially")
    }

}

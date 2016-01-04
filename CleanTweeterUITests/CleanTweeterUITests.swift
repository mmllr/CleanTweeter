//
//  CleanTweeterUITests.swift
//  CleanTweeterUITests
//
//  Created by Markus Müller on 04.01.16.
//  Copyright © 2016 Markus Müller. All rights reserved.
//

import XCTest

class CleanTweeterUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
 
        continueAfterFailure = false

        XCUIApplication().launch()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
		
		XCUIApplication().navigationBars["Clean Tweeter"].buttons["New Post"].tap()
		
		
        
    }
    
}

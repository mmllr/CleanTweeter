//
//  UserTests.swift
//  CleanTweeter
//
//  Created by Markus Müller on 31.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import XCTest
import CleanTweeter

class UserTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
	func testThatAUserHasAName() {
		let user = User(name: "u", followedUsers:[], tweets:[])

		XCTAssertEqual(user.name, "u")
	}

	func testThatAUserCannotFollowHimself() {
		let user = User(name: "u", followedUsers: ["u"], tweets: [])
	
		XCTAssertEqual(user.followedUsers, [])
	}

	func testThatAUserHaseOnlyDistinctFollowedUsers() {
		let user = User(name: "u", followedUsers: ["f1", "f2", "f2", "f3", "f1", "f3"], tweets: [])
		
		XCTAssertEqual(user.followedUsers, ["f1", "f2", "f3"])
	}
}

//
//  TweetListWireframeTests.swift
//  CleanTweeter
//
//  Created by Markus Müller on 04.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import XCTest
import CleanTweeterMac

class TweetListWireframeTests: XCTestCase {
	var sut: TweetListWireframe!
	
	override func setUp() {
		super.setUp()
		sut = TweetListWireframe(userRepository: UserRepositoryMock())
	}
	
	func testThatItHasAWindowController() {
		XCTAssertNotNil(sut.windowController)
	}
	
	func testThatTheModuleWiredUp() {
		XCTAssertNotNil(sut.interactor)
		XCTAssertNotNil(sut.presenter)
		XCTAssertTrue(sut.interactor.output is TweetListPresenter)
		XCTAssertTrue(sut.presenter.view is TweetListWindowController)
		XCTAssertTrue(sut.presenter.interactor is TweetListInteractor)
		XCTAssertTrue(sut.windowController.moduleInterface is TweetListPresenter)
	}
	
}

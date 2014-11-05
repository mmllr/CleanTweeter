//
//  TweetListPresenterTests.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import XCTest
#if os(iOS)
import CleanTweeter
import UIKit
#else
import CleanTweeterMac
import Cocoa
#endif


class TweetListPresenterTests: XCTestCase, TweetListView, TweetListInteractorInput {
	var sut: TweetListPresenter!
	var viewModel: [TweetListItem] = []
	var requestedUser: String = ""

    override func setUp() {
        super.setUp()

#if os(iOS)
		let resourceFactory = MobileResourceFactory()
#else
		let resourceFactory = OSXResourceFactory()
#endif
		sut = TweetListPresenter(resourceFactory: resourceFactory)
		sut.view = self
		sut.interactor = self
    }

	// MARK: TweetListInteractorInput
	
	func requestTweetsForUserName(userName: String) {
		self.requestedUser = userName
	}
	
	// MARK: TweetListView
	
	func updateViewModel(viewModel: [TweetListItem]) {
		self.viewModel = viewModel
	}

	// MARK: Tests
	
	func testThatItTransformsAResponseModelIntoToAViewModelAndUpdatesTheView() {
		let response = [
			TweetListResponseModel(user: "u1", content: "c1", age: "a1"),
			TweetListResponseModel(user: "u2", content: "c2", age: "a2"),
			TweetListResponseModel(user: "u3", content: "c3", age: "a3")
		]

		sut.foundTweets(response)

		XCTAssertEqual(self.viewModel, [
			TweetListItem(primaryHeading: "u1", secondaryHeading: "a1", content: NSAttributedString(string: "c1")),
			TweetListItem(primaryHeading: "u2", secondaryHeading: "a2", content: NSAttributedString(string: "c2")),
			TweetListItem(primaryHeading: "u3", secondaryHeading: "a3", content: NSAttributedString(string: "c3"))
			])
	}

	func testThatARequestForTheTweetListWillBePassedToTheInteractor() {
		sut.requestTweetsForUser("requested user")

		XCTAssertEqual(self.requestedUser, "requested user")
	}

	func testThatKeywordsInTweetsWillBeHighlighted() {
		let content = "@mention plain text #tag"

		let response = [
			TweetListResponseModel(user: "u1", content: content, age: "a1")
		]

		sut.foundTweets(response)

		let mentionRange = (content as NSString).rangeOfString("@mention")
		let tagRange = (content as NSString).rangeOfString("#tag")

		let expectedString = NSMutableAttributedString(string: content)

		for range in [mentionRange, tagRange] {
#if os(iOS)
			let color = UIColor.blueColor()
#else
			let color = NSColor.blueColor()
#endif
			expectedString.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
		}

		let viewModelItem = self.viewModel[0]
		XCTAssertEqual(viewModelItem.content, expectedString)
	}

}

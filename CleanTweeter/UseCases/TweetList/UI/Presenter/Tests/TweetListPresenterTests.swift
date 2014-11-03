//
//  TweetListPresenterTests.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import XCTest
import CleanTweeter

class TweetListPresenterTests: XCTestCase, TweetListView, TweetListInteractorInput {
	var sut: TweetListPresenter!
	var viewModel: [TweetListItem] = []
	var requestedUser: String = ""

    override func setUp() {
        super.setUp()

		sut = TweetListPresenter()
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
			TweetListItem(primaryHeading: "u1", secondaryHeading: "a1", content: "c1"),
			TweetListItem(primaryHeading: "u2", secondaryHeading: "a2", content: "c2"),
			TweetListItem(primaryHeading: "u3", secondaryHeading: "a3", content: "c3")
			])
	}

	func testThatARequestForTheTweetListWillBePassedToTheInteractor() {
		sut.requestTweetsForUser("requested user")

		XCTAssertEqual(self.requestedUser, "requested user")
	}

	func testThatAHashTagWillBeBlue() {
		let content = "#Hashtag"

		let range: NSRange = NSMakeRange(0, 0)
		let atributes = self.attributeTweet(content).attributesAtIndex(location: 0, effectiveRange: &range)
		
	}
	
	func attributeTweet(tweet: String) -> NSAttributedString {
		return NSAttributedString(string: tweet)
	}
}

//
//  TweetTests.swift
//  CleanTweeter
//
//  Created by Markus Müller on 31.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import XCTest
import CleanTweeter

class TweetTests: XCTestCase {

    override func setUp() {
        super.setUp()
	}

	func testThatATweetHasAnAuthor() {
		let sut = Tweet(author: "a", content: "")

		XCTAssertEqual(sut.author, "a")
	}

	func testThatATweetHasContent() {
		let sut = Tweet(author: "a", content: "content")

		XCTAssertEqual(sut.content, "content")
	}

	func testThatATweetHasAPublicationDate() {
		let expectedDate = NSDate()
		let sut = Tweet(author: "a", content: "content", publicationDate: expectedDate)

		XCTAssertEqual(sut.publicationDate, expectedDate)
	}

	func testThatATweetCreatedWithAPublicationDateInTheFutureWillHaveAPublictionDateOfTheCurrentDate() {
		let distantFutureDate: NSDate = NSDate.distantFuture() as NSDate

		let sut = Tweet(author: "a", content: "content", publicationDate: distantFutureDate)
		XCTAssertLessThanOrEqual(sut.publicationDate.timeIntervalSinceNow, 0)
	}
	
	func testThatTheContentCannotBeLongerThan160Elements() {
		let sut = Tweet(author: "a", content: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores")
		
		XCTAssertEqual(countElements(sut.content), 160)
	}

	func testThatTwoTweetsWithIdenticalPropertiesAreEqual() {
		let now = NSDate()
		let t1 = Tweet(author: "a", content: "c", publicationDate: now)
		let t2 = Tweet(author: "a", content: "c", publicationDate: now)

		XCTAssertEqual(t1, t2)
	}

	func testThatTwoTweetsWithDifferentAuthorsAreNotEqual() {
		let now = NSDate()
		let t1 = Tweet(author: "a", content: "c", publicationDate: now)
		let t2 = Tweet(author: "b", content: "c", publicationDate: now)
		
		XCTAssertNotEqual(t1, t2)
	}

	func testThatTwoTweetsWithDifferentPublicationDatesAreNotEqual() {
		let t1 = Tweet(author: "a", content: "c", publicationDate: NSDate.distantPast() as NSDate)
		let t2 = Tweet(author: "a", content: "c", publicationDate: NSDate())
		
		XCTAssertNotEqual(t1, t2)
	}

	func testThatTwoTweetsWithDifferentContentAreNotEqual() {
		let now = NSDate()
	
		let t1 = Tweet(author: "a", content: "c", publicationDate: now)
		let t2 = Tweet(author: "a", content: "other content", publicationDate: now)
		
		XCTAssertNotEqual(t1, t2)
	}

	func testThatThatATweetIsComparablebyDate() {
		let t1 = Tweet(author: "a", content: "c", publicationDate: NSDate.distantPast() as NSDate)
		let t2 = Tweet(author: "a", content: "c", publicationDate: NSDate.distantFuture() as NSDate)

		XCTAssertGreaterThan(t1, t2)
	}

	func testThatATweetWithOneMentionedUserHasTheUserWithoutTheAtSignInItsMentionedUsers() {
		let tweet = Tweet(author: "a", content: "@mentionedUser", publicationDate: NSDate())

		XCTAssertEqual(tweet.mentionedUsers, ["@mentionedUser"])
	}

	func testThatATweetWithMultipleMentionedUsersHasThemWithoutTheAtSignInItsMentionedUsersInTheOrderTheyAppear() {
		let tweet = Tweet(author: "a", content: "@u1 @u2 content @u3", publicationDate: NSDate())
		
		XCTAssertEqual(tweet.mentionedUsers, ["@u1", "@u2", "@u3"])
	}

	func testThatMentionedUsersOnlyAppearOnceInTheOrderTheyAppear() {
		let tweet = Tweet(author: "a", content: "@u1 @u2 content @u3 @u2", publicationDate: NSDate())

		XCTAssertEqual(tweet.mentionedUsers, ["@u1", "@u2", "@u3"])
	}

	func testThatATweetWithOneTagHasTheTag() {
		let tweet = Tweet(author: "a", content: "Tweet with #tag", publicationDate: NSDate())

		XCTAssertEqual(tweet.tags, ["#tag"])
	}

	func testThatATweetWithManyTagHasTheTagsInTheOrderAsTheAppear() {
		let tweet = Tweet(author: "a", content: "#tag and #other tags, just #another", publicationDate: NSDate())
		
		XCTAssertEqual(tweet.tags, ["#tag", "#other", "#another"])
	}

	func testThatTagsAreUnique() {
		let tweet = Tweet(author: "a", content: "#tag and #tag and another #tag", publicationDate: NSDate())
		
		XCTAssertEqual(tweet.tags, ["#tag"])
	}
}

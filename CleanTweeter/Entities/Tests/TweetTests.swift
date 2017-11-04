//
//  TweetTests.swift
//  CleanTweeter
//
//  Created by Markus Müller on 31.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import XCTest
#if os(iOS)
@testable import CleanTweeter
#else
@testable import CleanTweeterMac
#endif

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
		let expectedDate = Date()
		let sut = Tweet(author: "a", content: "content", publicationDate: expectedDate)

		XCTAssertEqual(sut.publicationDate, expectedDate)
	}

	func testThatATweetCreatedWithAPublicationDateInTheFutureWillHaveAPublictionDateOfTheCurrentDate() {
		let distantFutureDate: Date = Date.distantFuture as Date

		let sut = Tweet(author: "a", content: "content", publicationDate: distantFutureDate)
		XCTAssertLessThanOrEqual(sut.publicationDate.timeIntervalSinceNow, 0)
	}
	
	func testThatTheContentCannotBeLongerThan160Elements() {
		let sut = Tweet(author: "a", content: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores")
		
		XCTAssertEqual(sut.content.count, 160)
	}

	func testThatTwoTweetsWithIdenticalPropertiesAreEqual() {
		let now = Date()
		let t1 = Tweet(author: "a", content: "c", publicationDate: now)
		let t2 = Tweet(author: "a", content: "c", publicationDate: now)

		XCTAssertEqual(t1, t2)
	}

	func testThatTwoTweetsWithDifferentAuthorsAreNotEqual() {
		let now = Date()
		let t1 = Tweet(author: "a", content: "c", publicationDate: now)
		let t2 = Tweet(author: "b", content: "c", publicationDate: now)
		
		XCTAssertNotEqual(t1, t2)
	}

	func testThatTwoTweetsWithDifferentPublicationDatesAreNotEqual() {
		let t1 = Tweet(author: "a", content: "c", publicationDate: Date.distantPast as Date)
		let t2 = Tweet(author: "a", content: "c", publicationDate: Date())
		
		XCTAssertNotEqual(t1, t2)
	}

	func testThatTwoTweetsWithDifferentContentAreNotEqual() {
		let now = Date()
	
		let t1 = Tweet(author: "a", content: "c", publicationDate: now)
		let t2 = Tweet(author: "a", content: "other content", publicationDate: now)
		
		XCTAssertNotEqual(t1, t2)
	}

	func testThatThatATweetIsComparablebyDate() {
		let t1 = Tweet(author: "a", content: "c", publicationDate: Date.distantPast as Date)
		let t2 = Tweet(author: "a", content: "c", publicationDate: Date.distantFuture as Date)

		XCTAssertGreaterThan(t1, t2)
	}

	func testThatATweetWithOneMentionedUserHasTheUserInItsMentionedUsers() {
		let tweet = Tweet(author: "a", content: "@mentionedUser", publicationDate: Date())

		XCTAssertEqual(tweet.mentionedUsers, ["@mentionedUser"])
	}

	func testThatATweetWithMultipleMentionedUsersHasThemInItsMentionedUsersInTheOrderTheyAppear() {
		let tweet = Tweet(author: "a", content: "@u1 @u2 content @u3", publicationDate: Date())
		
		XCTAssertEqual(tweet.mentionedUsers, ["@u1", "@u2", "@u3"])
	}

	func testThatMentionedUsersOnlyAppearOnceInTheOrderTheyAppear() {
		let tweet = Tweet(author: "a", content: "@u1 @u2 content @u3 @u2", publicationDate: Date())

		XCTAssertEqual(tweet.mentionedUsers, ["@u1", "@u2", "@u3"])
	}

	func testThatATweetWithOneTagHasTheTag() {
		let tweet = Tweet(author: "a", content: "Tweet with #tag", publicationDate: Date())

		XCTAssertEqual(tweet.tags, ["#tag"])
	}

	func testThatATweetWithManyTagHasTheTagsInTheOrderAsTheAppear() {
		let tweet = Tweet(author: "a", content: "#tag and #other tags, just #another", publicationDate: Date())
		
		XCTAssertEqual(tweet.tags, ["#tag", "#other", "#another"])
	}

	func testThatTagsAreUnique() {
		let tweet = Tweet(author: "a", content: "#tag and #tag and another #tag", publicationDate: Date())
		
		XCTAssertEqual(tweet.tags, ["#tag"])
	}
}

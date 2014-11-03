//
//  TweetListInteractorTests.swift
//  CleanTweeter
//
//  Created by Markus Müller on 29.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import XCTest
import CleanTweeter

class TweetListInteractorTests: XCTestCase, TweetListInteractorOutput {
	var sut: TweetListInteractor?
	var repositoryMock: UserRepositoryMock = UserRepositoryMock()

	var response: [TweetListResponseModel] = []
	
    override func setUp() {
        super.setUp()

		sut = TweetListInteractor(repository:self.repositoryMock)
		sut!.output = self
    }

	// MARK: TweetListInteractorOutput
	
	func foundTweets(tweetlist: [TweetListResponseModel]) {
		self.response = tweetlist
	}

	// MARK: stubbing

	func givenADateDaysAgo(days: Int, hours: Int, minutes: Int, seconds: Int) -> NSDate {
		let timeInterval: NSTimeInterval = -NSTimeInterval(days*24*60*60 + (hours%24)*60*60 + (minutes%60)*60 + (seconds%60))
		 return NSDate(timeIntervalSinceNow: timeInterval)
	}
	
	func givenATweetCreatedDaysAgo(days: Int, hours: Int, minutes: Int, seconds: Int) {
		let tweet = Tweet(author: "u", content: "t1", publicationDate: self.givenADateDaysAgo(days, hours: hours, minutes: minutes, seconds: seconds))
		self.repositoryMock.givenTheUsers([User(name: "u", followedUsers: [], tweets:[tweet])])
	}
	
	// MARK: Tests
	
	func testThatAnEmptyFeedResultsInAnEmptyResponse() {
		self.repositoryMock.givenTheUsers([])

		sut!.requestTweetsForUserName("u")

		XCTAssertEqual(self.response, [])
	}

	func testThatOneTweetFromOneUserInTheRepositoryIsInTheResponse() {
		let tweet = Tweet(author: "u", content: "tweet")
		let user = User(name: "u", followedUsers: [], tweets:[tweet])
		self.repositoryMock.givenTheUsers([user])
		
		sut!.requestTweetsForUserName("u")

		XCTAssertEqual(self.response, [TweetListResponseModel(user: "u", content: "tweet", age: "0m")])
	}

	func testThatManyTweetsFromOneUserInTheRepositoryResultsInThatUsersTweetsOrderedByDate() {
		let tweets = [
			Tweet(author: "u", content: "t1", publicationDate:self.givenADateDaysAgo(0, hours: 0, minutes: 1, seconds: 0)),
			Tweet(author: "u", content: "t2", publicationDate:self.givenADateDaysAgo(0, hours: 0, minutes: 3, seconds: 0)),
			Tweet(author: "u", content: "t3", publicationDate:self.givenADateDaysAgo(0, hours: 0, minutes: 2, seconds: 0))
		]
		self.repositoryMock.givenTheUsers([User(name: "u", followedUsers: [], tweets:tweets)])

		sut!.requestTweetsForUserName("u")

		XCTAssertEqual(self.response, [
			TweetListResponseModel(user: "u", content: "t1", age: "1m"),
			TweetListResponseModel(user: "u", content: "t3", age: "2m"),
			TweetListResponseModel(user: "u", content: "t2", age: "3m")
			]
		)
	}

	func testThatThePublicationDateWillBeFormattedRelativeToTheReferenceDate() {
		self.givenATweetCreatedDaysAgo(0, hours: 0, minutes: 1, seconds: 0)
		sut!.requestTweetsForUserName("u")

		let responseModel = self.response[0]
		XCTAssertEqual(responseModel.age, "1m")
	}

	func testThatATweetMoreThanAnHourAgoWillShowNoMinutesInItsFormattedString() {
		self.givenATweetCreatedDaysAgo(0, hours: 1, minutes: 12, seconds: 0)

		sut!.requestTweetsForUserName("u")
		
		let responseModel = self.response[0]
		XCTAssertEqual(responseModel.age, "1h")
	}

	func testThatATweetMoreThanADayAgoWillShowNoHoursAndMinutesInItsFormattedString() {
		self.givenATweetCreatedDaysAgo(1, hours: 17, minutes: 10, seconds: 30)
		
		sut!.requestTweetsForUserName("u")
		
		let responseModel = self.response[0]
		XCTAssertEqual(responseModel.age, "2d")
	}

	func testThatATweetCreatedNowInItsFormattedString() {
		self.givenATweetCreatedDaysAgo(0, hours: 0, minutes: 0, seconds: 0)
		
		sut!.requestTweetsForUserName("u")
		
		let responseModel = self.response[0]
		XCTAssertEqual(responseModel.age, "0m")
	}

	func testThatATweetCreatedMoreThanAYearAgoShowsOnlyTheYearsInItsFormattedString() {
		self.givenATweetCreatedDaysAgo(400, hours: 10, minutes: 20, seconds: 0)

		sut!.requestTweetsForUserName("u")
		
		let responseModel = self.response[0]
		XCTAssertEqual(responseModel.age, "2y")
	}

	func testThatAUserWithNoTweetsButOneFollowerWillHaveHisTweetsInTheResponse() {
		let follower = User(name: "f", followedUsers: [], tweets:[
			Tweet(author: "f", content: "t1", publicationDate:self.givenADateDaysAgo(0, hours: 0, minutes: 1, seconds: 0)),
			Tweet(author: "f", content: "t2", publicationDate:self.givenADateDaysAgo(0, hours: 0, minutes: 3, seconds: 0))
			]
		)

		self.repositoryMock.givenTheUsers([
			User(name: "u", followedUsers: ["f"], tweets:[]),
			follower
			]
		)

		sut!.requestTweetsForUserName("u")
		
		XCTAssertEqual(self.response, [
			TweetListResponseModel(user: "f", content: "t1", age: "1m"),
			TweetListResponseModel(user: "f", content: "t2", age: "3m")
			]
		)
	}

	func testThatAUserWithTweetsAndFollowersWillHaveHisTweetsAnTheFollowersTweetsInTheResponseSortedByDate() {
		self.repositoryMock.givenTheUsers([
			User(name: "u", followedUsers: ["f"], tweets:[
				Tweet(author: "u", content: "u t1", publicationDate:self.givenADateDaysAgo(10, hours: 0, minutes: 0, seconds: 0)),
				Tweet(author: "u", content: "u t2", publicationDate: self.givenADateDaysAgo(0, hours: 2, minutes: 0, seconds: 0))
				]),
			User(name: "f", followedUsers: [], tweets:[
				Tweet(author: "f", content: "f t1", publicationDate:self.givenADateDaysAgo(0, hours: 0, minutes: 5, seconds: 0)),
				Tweet(author: "f", content: "f t2", publicationDate:self.givenADateDaysAgo(0, hours: 10, minutes: 0, seconds: 0))
				])
			])

		sut!.requestTweetsForUserName("u")
		
		XCTAssertEqual(self.response, [
			TweetListResponseModel(user: "f", content: "f t1", age: "5m"),
			TweetListResponseModel(user: "u", content: "u t2", age: "2h"),
			TweetListResponseModel(user: "f", content: "f t2", age: "10h"),
			TweetListResponseModel(user: "u", content: "u t1", age: "10d")
			]
		)
	}
}


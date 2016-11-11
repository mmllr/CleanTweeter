
import XCTest
#if os(iOS)
@testable import CleanTweeter
#else
@testable import CleanTweeterMac
#endif
	
class TweetListInteractorTests: XCTestCase, TweetListInteractorOutput {
	var sut: TweetListInteractor?
	var repositoryMock: UserRepositoryMock = UserRepositoryMock()
	let dateFormatter = DateComponentsFormatter()

	var response: [TweetListResponseModel] = []
	
    override func setUp() {
        super.setUp()

		dateFormatter.unitsStyle = .abbreviated
		dateFormatter.allowedUnits = [.year, .day, .hour, .minute]
		dateFormatter.maximumUnitCount = 1
		sut = TweetListInteractor(repository:self.repositoryMock)
		sut!.output = self
    }

	// MARK: TweetListInteractorOutput
	
	func foundTweets(_ tweetlist: [TweetListResponseModel]) {
		self.response = tweetlist
	}

	// MARK: stubbing

	func givenADateDaysAgo(_ days: Int, hours: Int, minutes: Int, seconds: Int) -> Date {
		let timeInterval: TimeInterval = -TimeInterval(days*24*60*60 + (hours%24)*60*60 + (minutes%60)*60 + (seconds%60))
		 return Date(timeIntervalSinceNow: timeInterval)
	}
	
	func givenATweetCreatedDaysAgo(_ days: Int, hours: Int, minutes: Int, seconds: Int) -> Date {
		let date = self.givenADateDaysAgo(days, hours: hours, minutes: minutes, seconds: seconds)
		let tweet = Tweet(author: "u", content: "t1", publicationDate: date)
		self.repositoryMock.givenTheUsers([User(name: "u", followedUsers: [], tweets:[tweet])])
		return date
	}
	
	// MARK: Test helpers
	
	func expectedAgeStringForDate(_ date: Date) -> String {
		return dateFormatter.string(from: date, to: Date())!
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

		XCTAssertEqual(self.response, [TweetListResponseModel(user: "u", content: "tweet", age: expectedAgeStringForDate(tweet.publicationDate), avatar: "")])
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
			TweetListResponseModel(user: "u", content: "t1", age: expectedAgeStringForDate(tweets[0].publicationDate), avatar: ""),
			TweetListResponseModel(user: "u", content: "t3", age: expectedAgeStringForDate(tweets[2].publicationDate), avatar: ""),
			TweetListResponseModel(user: "u", content: "t2", age: expectedAgeStringForDate(tweets[1].publicationDate), avatar: "")
			]
		)
	}

	func testThatThePublicationDateWillBeFormattedRelativeToTheReferenceDate() {
		let tweetDate = givenATweetCreatedDaysAgo(0, hours: 0, minutes: 1, seconds: 0)
		sut!.requestTweetsForUserName("u")

		let responseModel = self.response[0]
		XCTAssertEqual(responseModel.age, expectedAgeStringForDate(tweetDate))
	}

	func testThatATweetMoreThanAnHourAgoWillShowNoMinutesInItsFormattedString() {
		let tweetDate = givenATweetCreatedDaysAgo(0, hours: 1, minutes: 12, seconds: 0)

		sut!.requestTweetsForUserName("u")
		
		let responseModel = self.response[0]
		XCTAssertEqual(responseModel.age, expectedAgeStringForDate(tweetDate))
	}

	func testThatATweetMoreThanADayAgoWillShowNoHoursAndMinutesInItsFormattedString() {
		let tweetDate = givenATweetCreatedDaysAgo(1, hours: 17, minutes: 10, seconds: 30)
		
		sut!.requestTweetsForUserName("u")
		
		let responseModel = self.response[0]
		XCTAssertEqual(responseModel.age, expectedAgeStringForDate(tweetDate))
	}

	func testThatATweetCreatedNowInItsFormattedString() {
		let tweetDate = givenATweetCreatedDaysAgo(0, hours: 0, minutes: 0, seconds: 0)
		
		sut!.requestTweetsForUserName("u")
		
		let responseModel = self.response[0]
		XCTAssertEqual(responseModel.age, expectedAgeStringForDate(tweetDate))
	}

	func testThatATweetCreatedMoreThanAYearAgoShowsOnlyTheYearsInItsFormattedString() {
		let tweetDate = givenATweetCreatedDaysAgo(400, hours: 10, minutes: 20, seconds: 0)

		sut!.requestTweetsForUserName("u")
		
		let responseModel = self.response[0]
		XCTAssertEqual(responseModel.age, expectedAgeStringForDate(tweetDate))
	}

	func testThatAUserWithNoTweetsButOneFollowerWillHaveHisTweetsInTheResponse() {
		let follower = User(name: "f", followedUsers: [], tweets:[
			Tweet(author: "f", content: "t1", publicationDate:self.givenADateDaysAgo(0, hours: 0, minutes: 1, seconds: 0)),
			Tweet(author: "f", content: "t2", publicationDate:self.givenADateDaysAgo(0, hours: 0, minutes: 3, seconds: 0))
			], avatar: "avatar")
		self.repositoryMock.givenTheUsers([User(name: "u", followedUsers: ["f"], tweets:[]), follower])

		sut!.requestTweetsForUserName("u")
		
		XCTAssertEqual(self.response, [
			TweetListResponseModel(user: "f", content: "t1", age: expectedAgeStringForDate(follower.tweets[0].publicationDate), avatar: "avatar"),
			TweetListResponseModel(user: "f", content: "t2", age: expectedAgeStringForDate(follower.tweets[1].publicationDate), avatar: "avatar")
			]
		)
	}

	func testThatAUserWithTweetsAndFollowersWillHaveHisTweetsAnTheFollowersTweetsInTheResponseSortedByDate() {
		let user = User(name: "u", followedUsers: ["f"], tweets:[
			Tweet(author: "u", content: "u t1", publicationDate:givenADateDaysAgo(10, hours: 0, minutes: 0, seconds: 0)),
			Tweet(author: "u", content: "u t2", publicationDate:givenADateDaysAgo(0, hours: 2, minutes: 0, seconds: 0))
			], avatar: "u-avatar")
		let follower = User(name: "f", followedUsers: [], tweets:[
			Tweet(author: "f", content: "f t1", publicationDate:givenADateDaysAgo(0, hours: 0, minutes: 5, seconds: 0)),
			Tweet(author: "f", content: "f t2", publicationDate:givenADateDaysAgo(0, hours: 10, minutes: 0, seconds: 0))
			], avatar: "f-avatar")
		self.repositoryMock.givenTheUsers([user, follower])

		sut!.requestTweetsForUserName("u")
		
		XCTAssertEqual(self.response, [
			TweetListResponseModel(user: "f", content: "f t1", age: expectedAgeStringForDate(follower.tweets[0].publicationDate), avatar: "f-avatar"),
			TweetListResponseModel(user: "u", content: "u t2", age: expectedAgeStringForDate(user.tweets[1].publicationDate), avatar: "u-avatar"),
			TweetListResponseModel(user: "f", content: "f t2", age: expectedAgeStringForDate(follower.tweets[1].publicationDate), avatar: "f-avatar"),
			TweetListResponseModel(user: "u", content: "u t1", age: expectedAgeStringForDate(user.tweets[0].publicationDate), avatar: "u-avatar")
			]
		)
	}
}


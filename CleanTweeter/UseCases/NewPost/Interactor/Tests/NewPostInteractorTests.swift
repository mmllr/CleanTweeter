
import XCTest
@testable import CleanTweeter

class RepositorySpy : UserRepository {
	var requestedUser: String?
	var mockedUser: User?
	var updatedUser: User?
	
	func findUser(userName: String) -> User? {
		requestedUser = userName
		return mockedUser
	}
	
	func updateUser(user: User) {
		updatedUser = user
	}
	
	func givenTheUser(user: User) {
		mockedUser = user
	}
}

class OutputSpy : NewPostInteractorOutput {
	var avatar: String?

	func foundAvatar(avatar: String) {
		self.avatar = avatar
	}
}

class NewPostInteractorTests: XCTestCase {
	var sut: NewPostInteractor!
	var repositorySpy = RepositorySpy()

    override func setUp() {
        super.setUp()
	}

    override func tearDown() {
        super.tearDown()
    }

	func testThatANewPostAsksTheRepositoryForThatUser() {
		sut = NewPostInteractor(repository: repositorySpy)

		sut.postContent("new post", forUser: "u", publicationDate: NSDate())

		XCTAssertEqual(repositorySpy.requestedUser, "u")
	}

	func testThatANewPostWillAppendTheContentToTheUserWithNoTweetsInTheRepository() {
		sut = NewPostInteractor(repository: repositorySpy)
		repositorySpy.givenTheUser(User(name: "user", followedUsers: [], tweets: []))

		let date = NSDate()
		sut.postContent("new post", forUser: "user", publicationDate: date)

		XCTAssertEqual(User(name: "user", followedUsers: [], tweets: [Tweet(author: "user", content: "new post", publicationDate: date)]), repositorySpy.updatedUser)
	}

	func testThatANewPostWillAppendTheContentToTheUserWithTweetsInTheRepository() {
		sut = NewPostInteractor(repository: repositorySpy)
		let tweetDate = NSDate()
		repositorySpy.givenTheUser(User(name: "user", followedUsers: [], tweets: [Tweet(author: "user", content: "c1", publicationDate: tweetDate)], avatar: "my avatar"))
		
		let date = NSDate()
		sut.postContent("new post", forUser: "user", publicationDate: date)
		
		XCTAssertEqual(User(name: "user", followedUsers: [], tweets: [Tweet(author: "user", content: "c1", publicationDate: tweetDate),
			Tweet(author: "user", content: "new post", publicationDate: date)], avatar: "my avatar"), repositorySpy.updatedUser)
	}

	func testThatPostingATweetForAnUnknownUserWillDoNothing() {
		sut = NewPostInteractor(repository: repositorySpy)
		
		let date = NSDate()
		sut.postContent("new post", forUser: "user", publicationDate: date)
		
		XCTAssertEqual(nil, repositorySpy.updatedUser)
	}

	func testThatItAsksForAnAvatarForAGivenUser() {
		sut = NewPostInteractor(repository: repositorySpy)
		repositorySpy.givenTheUser(User(name: "user", followedUsers: [], tweets: [], avatar: "avatar"))
		let spy = OutputSpy()
		sut.output = spy
		sut.requestAvatarForUserName("user")

		XCTAssertEqual(repositorySpy.requestedUser, "user")
		XCTAssertEqual(spy.avatar, "avatar")
	}
}

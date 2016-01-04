
import XCTest
@testable import CleanTweeter

class TweetListWireframeTests: XCTestCase {
	var sut: TweetListWireframe!

    override func setUp() {
        super.setUp()
		sut = TweetListWireframe(userRepository: UserRepositoryMock())
    }

	func testThatItHasAViewController() {
		XCTAssertNotNil(sut.viewController)
	}

	func testThatTheModuleWiredUp() {
		XCTAssertNotNil(sut.interactor)
		XCTAssertNotNil(sut.presenter)
		XCTAssertTrue(sut.interactor.output is TweetListPresenter)
		XCTAssertTrue(sut.presenter.view is TweetListTableViewController)
		XCTAssertTrue(sut.presenter.interactor is TweetListInteractor)
		XCTAssertTrue(sut.viewController.moduleInterface is TweetListPresenter)
	}
}

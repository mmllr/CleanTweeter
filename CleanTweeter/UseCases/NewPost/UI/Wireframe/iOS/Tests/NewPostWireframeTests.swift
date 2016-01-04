
import XCTest
@testable import CleanTweeter

class NewPostWireframeTests: XCTestCase {
	var sut: NewPostWireframe!

    override func setUp() {
        super.setUp()
		sut = NewPostWireframe(userRepository: UserRepositoryMock())
    }
    
    override func tearDown() {
        
        super.tearDown()
    }

	func testThatItHasAViewController() {
		let viewController = sut.viewController
		XCTAssertNotNil(viewController)
		XCTAssertTrue(viewController.moduleInterface is NewPostPresenter)
		XCTAssertTrue(sut.presenter.view is NewPostViewController)
	}

	func testThatTheModuleIsWireup() {
		XCTAssertNotNil(sut.presenter)
		XCTAssertNotNil(sut.interactor)
		XCTAssertTrue(sut.presenter.interactor is NewPostInteractor)
		XCTAssertTrue(sut.interactor.output is NewPostPresenter)
	}
}

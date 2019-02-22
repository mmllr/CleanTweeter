
import XCTest
import UIKit
@testable import CleanTweeter

class NewPostModuleInterfaceSpy : NewPostInterface {
	var requestedContent: String?
	var postInvoked: Bool?

	func requestViewForContent(_ content: String) {
		self.requestedContent = content
	}

	func post() {
		self.postInvoked = true
	}
}

class NewPostRoutingDelegateSpy : NewPostRoutingDelegate {
	var hideNewPostViewInvoked = false

	func hideNewPostView() {
		hideNewPostViewInvoked = true
	}
}

class NewPostViewControllerTests: XCTestCase {
	var sut: NewPostViewController!
	var view: UIView!
	var spy = NewPostModuleInterfaceSpy()

    override func setUp() {
        super.setUp()
		sut = UIStoryboard(name: "NewPost", bundle:nil).instantiateInitialViewController() as? NewPostViewController
		self.view = sut.view!
    }
    
    override func tearDown() {
        super.tearDown()
    }

	func testThatItExists() {
		XCTAssertNotNil(sut)
		XCTAssertNotNil(sut.view)
	}

	func testThatUpdatingTheViewWorks() {
		let viewModel = NewPostViewModel(name: "name", avatar: "gravatar", content: NSAttributedString(string: "content"), characterCount: "42", canEdit: true, canPost: true)

		sut.updateView(viewModel)

		XCTAssertEqual(sut.title, viewModel.name)
		XCTAssertEqual(sut.contentTextView?.text, viewModel.content.string)
		XCTAssertEqual(sut.countLabel.text!, viewModel.characterCount)
	}

	func testThatItIsTheContentTextViewsDelegate() {
		XCTAssertNotNil(sut.contentTextView!.delegate)
		XCTAssertEqual(sut.contentTextView.delegate as? NewPostViewController, sut)
	}

	func testThatATextViewDidChangeMethodWillSendTheContentOfTheViewToTheModuleInterface() {
		sut.moduleInterface = self.spy
		sut.contentTextView.text = "new text"

		sut.textViewDidChange(sut.contentTextView)

		XCTAssertEqual(self.spy.requestedContent, "new text")
	}

	func testThatInvokingTheDoneActionMethodWillInformTheRoutingDelegate() {
		let spy = NewPostRoutingDelegateSpy()
		sut.routingDelegate = spy

		sut.done(self)

		XCTAssertTrue(spy.hideNewPostViewInvoked)
	}

	func testThatInvokingTheDoneActionMethodWillInformTheModuleInterface() {
		sut.moduleInterface = self.spy
		
		sut.done(self)
		
		XCTAssertEqual(self.spy.postInvoked, true)
	}

	func testThatItHasADoneRightBarItem() {
		let item = sut.navigationItem.rightBarButtonItem!

		XCTAssertNotNil(item)
		XCTAssertEqual(item.target as? NewPostViewController, sut)
		XCTAssertEqual(item.action, #selector(NewPostViewController.done(_:)))
	}

	func testThatItHasACancelLeftBarItem() {
		let item = sut.navigationItem.leftBarButtonItem!
		
		XCTAssertNotNil(item)
		XCTAssertEqual(item.target as? NewPostViewController, sut)
		XCTAssertEqual(item.action, #selector(NewPostViewController.cancel(_:)))
	}

	func testThatViewWillAppearWillRequestAViewModel() {
		sut.moduleInterface = self.spy
		sut.viewWillAppear(false)

		XCTAssertNotNil(self.spy.requestedContent)  
	}

	func testThatTheDoneButtonWillReflectTheViewModelsCanPost() {
		var viewModel = NewPostViewModel(name: "name", avatar: "gravatar", content: NSAttributedString(string: "content"), characterCount: "42", canEdit: true, canPost: true)
		
		sut.updateView(viewModel)

		XCTAssertTrue(sut.navigationItem.rightBarButtonItem!.isEnabled)

		viewModel.canPost = false
		sut.updateView(viewModel)
		
		XCTAssertFalse(sut.navigationItem.rightBarButtonItem!.isEnabled)
	}

	func testThatInvokingTheCancelActionMethodWillInformTheRoutingDelegate() {
		let spy = NewPostRoutingDelegateSpy()
		sut.routingDelegate = spy
		
		sut.cancel(self)
		
		XCTAssertTrue(spy.hideNewPostViewInvoked)
	}
	
	func testThatInvokingTheCancelActionMethodWillNotInformTheModuleInterface() {
		sut.moduleInterface = self.spy
		
		sut.cancel(self)
		
		XCTAssertNil(self.spy.postInvoked)
	}

	func testThatUpdatingTheViewModelWillSetTheAvatarImageView() {
		let viewModel = NewPostViewModel(name: "name", avatar: "gravatar", content: NSAttributedString(string: "content"), characterCount: "42", canEdit: true, canPost: true)
		
		sut.updateView(viewModel)

		XCTAssertNotNil(sut.avatarImageView.image)
	}
}

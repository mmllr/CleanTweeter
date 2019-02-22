
import UIKit
import XCTest
@testable import CleanTweeter

class TweetListTableViewControllerTests: XCTestCase, TweetListInterface {
	class RoutingDelegateSpy : TweetListRoutingDelegate {
		var newPostInvoked = false

		func createNewPost() {
			newPostInvoked = true
		}
	}
	var sut: TweetListTableViewController!
	var view: UIView!
	var tableView: UITableView!
	var requestedUser: String = ""
	var viewModel: [TweetListItem] = [
		TweetListItem(primaryHeading: "Item 1 - 1.Heading", secondaryHeading: "Item 1 - 2.Heading", content: NSAttributedString(string: "Item 1 - content"), imageName: "placeholder"),
		TweetListItem(primaryHeading: "Item 2 - 1.Heading", secondaryHeading: "Item 2 - 2.Heading", content: NSAttributedString(string: "Item 2 - content"), imageName: "placeholder"),
		TweetListItem(primaryHeading: "Item 3 - 1.Heading", secondaryHeading: "Item 3 - 2.Heading", content: NSAttributedString(string: "Item 3 - content"), imageName: "placeholder")
	]

    override func setUp() {
        super.setUp()
		sut = UIStoryboard(name: "TweetList", bundle:nil).instantiateInitialViewController() as? TweetListTableViewController
		self.view = sut.view!
		self.tableView = sut.tableView
		sut.moduleInterface = self
    }

	override func tearDown() {
		self.view = nil
		self.tableView = nil
		super.tearDown()
	}
	// MARK: TweetListInterface
	
	func requestTweetsForUser(_ userName: String) {
		self.requestedUser = userName
	}
	
	// MARK: Tests
	
	func testThatItExists() {
		XCTAssertNotNil(sut)
	}

	func testThatTheTableViewHasVariableRowHeights() {
		XCTAssertEqual(self.tableView.estimatedRowHeight, CGFloat(60.0))
		XCTAssertEqual(self.tableView.rowHeight, UITableView.automaticDimension)
	}
	
	func testThatItLoadsTheViewModel() {
		sut.updateViewModel(self.viewModel)

		for (index, item) in (viewModel).enumerated() {
			let headingCell = sut.tableView(self.tableView, cellForRowAt: IndexPath(row: index, section: 0)) as! HeadingContentCell

			XCTAssertEqual(headingCell.primaryHeadingLabel.text!, item.primaryHeading)
			XCTAssertEqual(headingCell.secondaryContentLabel.text!, item.secondaryHeading)
			XCTAssertEqual(headingCell.contentLabel.attributedText!, item.content)
			XCTAssertNotNil(headingCell.circularImageView)
			XCTAssertEqual(headingCell.circularImageView.accessibilityLabel, item.primaryHeading)
		}
	}

	func testThatItRequestTweetsWhenTheViewAppears() {
		sut.viewWillAppear(false)

		XCTAssertEqual(self.requestedUser, "Tim Cook")
	}

	func testThatTheTableViewDoesNotShowSeparators() {
		let expectedStyle: UITableViewCell.SeparatorStyle = .none
		XCTAssertEqual(sut.tableView.separatorStyle, expectedStyle)
	}

	func testThatItHasAnPostTweetButton() {
		XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)

		let item = sut.navigationItem.rightBarButtonItem!
		XCTAssertEqual(item.title, NSLocalizedString("New Post", comment: "New Post"))
		XCTAssertEqual(item.target as? TweetListTableViewController, sut)
		XCTAssertEqual(item.action, #selector(TweetListTableViewController.newPost(_:)))
	}

	func testThatTheNewPostActionMethodWillInvokeNewPostOnTheRoutingDelegate() {
		let spy = RoutingDelegateSpy()
		sut.routingDelegate = spy

		sut.newPost(self)

		XCTAssertTrue(spy.newPostInvoked)
	}
}

//
//  TweetListTableViewControllerTests.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import UIKit
import XCTest
@testable import CleanTweeter

class TweetListTableViewControllerTests: XCTestCase, TweetListInterface {
	var sut: TweetListTableViewController!
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
		self.tableView = sut?.tableView
		sut.moduleInterface = self
    }

	// MARK: TweetListInterface
	
	func requestTweetsForUser(userName: String) {
		self.requestedUser = userName
	}
	
	// MARK: Tests
	
	func testThatItExists() {
		XCTAssertNotNil(sut)
	}

	func testThatTheTableViewHasVariableRowHeights() {
		XCTAssertEqual(self.tableView.estimatedRowHeight, CGFloat(60.0))
		XCTAssertEqual(self.tableView.rowHeight, UITableViewAutomaticDimension)
	}
	
	func testThatItLoadsTheViewModel() {
		sut?.updateViewModel(self.viewModel)

		for (index, item) in (viewModel).enumerate() {
			let headingCell = sut?.tableView(self.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: index, inSection: 0)) as! HeadingContentCell

			XCTAssertEqual(headingCell.primaryHeadingLabel.text!, item.primaryHeading)
			XCTAssertEqual(headingCell.secondaryContentLabel.text!, item.secondaryHeading)
			XCTAssertEqual(headingCell.contentLabel.attributedText!, item.content)
			XCTAssertNotNil(headingCell.circularImageView)
		}
	}

	func testThatItRequestTweetsWhenTheViewAppears() {
		sut.viewWillAppear(false)

		XCTAssertEqual(self.requestedUser, "Tim Cook")
	}
}

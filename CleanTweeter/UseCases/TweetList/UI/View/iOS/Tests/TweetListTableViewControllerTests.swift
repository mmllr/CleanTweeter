//
//  TweetListTableViewControllerTests.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import UIKit
import XCTest
import CleanTweeter

class TweetListTableViewControllerTests: XCTestCase, TweetListInterface {
	var sut: TweetListTableViewController!
	var tableView: UITableView!
	var requestedUser: String = ""
	var viewModel: [TweetListItem] = [
		TweetListItem(primaryHeading: "Item 1 - 1.Heading", secondaryHeading: "Item 1 - 2.Heading", content: "Item 1 - content"),
		TweetListItem(primaryHeading: "Item 2 - 1.Heading", secondaryHeading: "Item 2 - 2.Heading", content: "Item 2 - content"),
		TweetListItem(primaryHeading: "Item 3 - 1.Heading", secondaryHeading: "Item 3 - 2.Heading", content: "Item 3 - content")
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

		for (index, item) in enumerate(viewModel) {
			let headingCell = sut?.tableView(self.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: index, inSection: 0)) as HeadingContentCell

			XCTAssertEqual(headingCell.primaryHeadingLabel.text!, viewModel[index].primaryHeading)
			XCTAssertEqual(headingCell.secondaryContentLabel.text!, viewModel[index].secondaryHeading)
			XCTAssertEqual(headingCell.contentLabel.text!, viewModel[index].content)
		}
	}

	func testThatItRequestTweetsWhenTheViewAppears() {
		sut.viewWillAppear(false)

		XCTAssertEqual(self.requestedUser, "Tim Cook")
	}
}

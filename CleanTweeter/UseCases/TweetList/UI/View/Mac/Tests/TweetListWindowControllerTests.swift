//
//  TweetListWindowControllerTests.swift
//  CleanTweeter
//
//  Created by Markus Müller on 04.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Cocoa
import XCTest
@testable import CleanTweeterMac

class TweetListWindowControllerTests: XCTestCase, TweetListInterface {
	var sut: TweetListWindowController!
	var requestedUser: String = ""
	var viewModel: [TweetListItem] = [
		TweetListItem(primaryHeading: "Item 1 - 1.Heading", secondaryHeading: "Item 1 - 2.Heading", content: NSAttributedString(string: "Item 1 - content"), imageName: ""),
		TweetListItem(primaryHeading: "Item 2 - 1.Heading", secondaryHeading: "Item 2 - 2.Heading", content: NSAttributedString(string: "Item 2 - content"), imageName: ""),
		TweetListItem(primaryHeading: "Item 3 - 1.Heading", secondaryHeading: "Item 3 - 2.Heading", content: NSAttributedString(string: "Item 3 - content"), imageName: "")
	]

    override func setUp() {
        super.setUp()
		sut = TweetListWindowController(windowNibName: "TweetListWindow")
		sut.moduleInterface = self
		sut.loadWindow()
    }

	// MARK: TweetListInterface
	
	func requestTweetsForUser(_ userName: String) {
		self.requestedUser = userName
	}
	
	func testThatItIsNotNil() {
		XCTAssertNotNil(sut)
	}

	func testThatItRequestTweetsWhenTheWindowDidLoad() {
		sut.windowDidLoad()

		XCTAssertEqual(self.requestedUser, "Tim Cook")
	}

	func testThatItLoadsTheViewModel() {
		sut.updateViewModel(self.viewModel)

		for (index, item) in viewModel.enumerated() {
			let headingCell = sut.tableView!.view(atColumn: 0, row: index, makeIfNecessary: true) as? HeadingContentCell

			XCTAssertEqual(headingCell?.primaryHeadingLabel.stringValue, item.primaryHeading)
			XCTAssertEqual(headingCell?.secondaryHeadingLabel.stringValue, item.secondaryHeading)
			XCTAssertEqual(headingCell?.contentLabel.attributedStringValue, item.content)
		}
	}

}

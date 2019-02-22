//
//  TweetListWindowController.swift
//  CleanTweeter
//
//  Created by Markus Müller on 04.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation
import Cocoa

class TweetListWindowController : NSWindowController, TweetListView, NSTableViewDataSource, NSTableViewDelegate {
	@IBOutlet open weak var tableView: NSTableView?
	var viewModel: [TweetListItem] = []

	var moduleInterface: TweetListInterface?

	func updateViewModel(_ viewModel: [TweetListItem]) {
		self.viewModel = viewModel
		tableView?.reloadData()
	}

	override func windowDidLoad() {
		moduleInterface?.requestTweetsForUser("Tim Cook")
	}

	func numberOfRows(in aTableView: NSTableView) -> Int {
		return self.viewModel.count
	}

	func tableView(_ tableView: NSTableView, viewFor viewForTableColumn: NSTableColumn?, row: Int) -> NSView? {
		let view = tableView.makeView( withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "HeadingContentCell"), owner: self) as! HeadingContentCell

		view.primaryHeadingLabel.stringValue = viewModel[row].primaryHeading
		view.secondaryHeadingLabel.stringValue = viewModel[row].secondaryHeading
		view.contentLabel.attributedStringValue = viewModel[row].content
		return view
	}
}

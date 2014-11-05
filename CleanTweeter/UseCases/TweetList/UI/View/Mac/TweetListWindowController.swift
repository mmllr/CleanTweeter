//
//  TweetListWindowController.swift
//  CleanTweeter
//
//  Created by Markus Müller on 04.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation
import Cocoa

public class TweetListWindowController : NSWindowController, TweetListView {
	@IBOutlet public weak var tableView: NSTableView?
	var viewModel: [TweetListItem] = []

	public var moduleInterface: TweetListInterface?

	public func updateViewModel(viewModel: [TweetListItem]) {
		self.viewModel = viewModel
		tableView?.reloadData()
	}

	override public func windowDidLoad() {
		moduleInterface?.requestTweetsForUser("Tim Cook")
	}

	func numberOfRowsInTableView(aTableView: NSTableView!) -> Int {
		return self.viewModel.count
	}

	func tableView(tableView: NSTableView!, viewForTableColumn: NSTableColumn!, row: Int) -> NSView! {
		let view = tableView.makeViewWithIdentifier( "HeadingContentCell", owner: self) as HeadingContentCell

		view.primaryHeadingLabel.stringValue = viewModel[row].primaryHeading
		view.secondaryHeadingLabel.stringValue = viewModel[row].secondaryHeading
		view.contentLabel.attributedStringValue = viewModel[row].content
		return view
	}
}

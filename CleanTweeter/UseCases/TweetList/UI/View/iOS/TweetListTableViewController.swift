//
//  TweetListTableViewController.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import UIKit

public class TweetListTableViewController: UITableViewController, TweetListView {
	public var moduleInterface: TweetListInterface?
	var viewModel: [TweetListItem] = []
	
	public func updateViewModel(viewModel: [TweetListItem]) {
		self.viewModel = viewModel
		self.tableView.dataSource = self
		self.tableView.reloadData()
	}

	override public func viewDidLoad() {
		super.viewDidLoad()

		self.tableView.estimatedRowHeight = CGFloat(60)
		self.tableView.rowHeight = UITableViewAutomaticDimension
	}

	public override func viewWillAppear(animated: Bool) {
		self.moduleInterface?.requestTweetsForUser("Tim Cook")
	}
	
	public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.count
	}

	public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell: AnyObject? = tableView.dequeueReusableCellWithIdentifier("HeadingContentCell")
		if let contentCell = cell as? HeadingContentCell {
			contentCell.primaryHeadingLabel.text = self.viewModel[indexPath.row].primaryHeading
			contentCell.secondaryContentLabel.text = self.viewModel[indexPath.row].secondaryHeading
			contentCell.contentLabel.text = self.viewModel[indexPath.row].content
		}
		return cell! as UITableViewCell
	}

}

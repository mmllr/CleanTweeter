//
//  TweetListTableViewController.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import UIKit

class TweetListTableViewController: UITableViewController, TweetListView {
	var moduleInterface: TweetListInterface?
	var viewModel: [TweetListItem] = []
	
	func updateViewModel(viewModel: [TweetListItem]) {
		self.viewModel = viewModel
		self.tableView.dataSource = self
		self.tableView.reloadData()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.tableView.estimatedRowHeight = CGFloat(60)
		self.tableView.rowHeight = UITableViewAutomaticDimension
	}

	override func viewWillAppear(animated: Bool) {
		self.moduleInterface?.requestTweetsForUser("Tim Cook")
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.count
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let contentCell = tableView.dequeueReusableCellWithIdentifier("HeadingContentCell") as! HeadingContentCell!
		contentCell.primaryHeadingLabel.text = self.viewModel[indexPath.row].primaryHeading
		contentCell.secondaryContentLabel.text = self.viewModel[indexPath.row].secondaryHeading
		contentCell.contentLabel.attributedText = self.viewModel[indexPath.row].content
		contentCell.circularImageView.image = UIImage(named: self.viewModel[indexPath.row].imageName)!
		contentCell.circularImageView.accessibilityLabel = self.viewModel[indexPath.row].primaryHeading
		return contentCell
	}

}

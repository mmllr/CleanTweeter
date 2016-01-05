
import UIKit

class TweetListTableViewController: UITableViewController, TweetListView {
	var moduleInterface: TweetListInterface?
	var viewModel: [TweetListItem] = []
	var routingDelegate: TweetListRoutingDelegate?

	func updateViewModel(viewModel: [TweetListItem]) {
		self.viewModel = viewModel
		self.tableView.dataSource = self
		self.tableView.reloadData()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.tableView.estimatedRowHeight = CGFloat(60)
		self.tableView.rowHeight = UITableViewAutomaticDimension
		self.tableView.separatorStyle = .None
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("New Post", comment: "New Post"), style: .Plain, target: self, action: Selector("newPost:"))
		self.navigationItem.rightBarButtonItem?.accessibilityIdentifier = "New Post"
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
		if let data = NSData(contentsOfURL: NSURL(string: self.viewModel[indexPath.row].imageName)!) {
			contentCell.circularImageView.image = UIImage(data: data)
		}
		else {
			contentCell.circularImageView.image = UIImage(named: self.viewModel[indexPath.row].imageName)!
		}
		contentCell.circularImageView.accessibilityLabel = self.viewModel[indexPath.row].primaryHeading
		return contentCell
	}
	
	@IBAction func newPost(sender: AnyObject?) {
		self.routingDelegate?.createNewPost()
	}

}


import UIKit

class TweetListTableViewController: UITableViewController, TweetListView {
	var moduleInterface: TweetListInterface?
	var viewModel: [TweetListItem] = []
	var routingDelegate: TweetListRoutingDelegate?

	func updateViewModel(_ viewModel: [TweetListItem]) {
		self.viewModel = viewModel
		self.tableView.dataSource = self
		self.tableView.reloadData()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.tableView.estimatedRowHeight = CGFloat(60)
		self.tableView.rowHeight = UITableViewAutomaticDimension
		self.tableView.separatorStyle = .none
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("New Post", comment: "New Post"), style: .plain, target: self, action: #selector(TweetListTableViewController.newPost(_:)))
		self.navigationItem.rightBarButtonItem?.accessibilityIdentifier = "New Post"
	}

	override func viewWillAppear(_ animated: Bool) {
		self.moduleInterface?.requestTweetsForUser("Tim Cook")
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let contentCell = tableView.dequeueReusableCell(withIdentifier: "HeadingContentCell") as! HeadingContentCell!
		contentCell?.primaryHeadingLabel.text = self.viewModel[(indexPath as NSIndexPath).row].primaryHeading
		contentCell?.secondaryContentLabel.text = self.viewModel[(indexPath as NSIndexPath).row].secondaryHeading
		contentCell?.contentLabel.attributedText = self.viewModel[(indexPath as NSIndexPath).row].content
		if let data = try? Data(contentsOf: URL(string: self.viewModel[(indexPath as NSIndexPath).row].imageName)!) {
			contentCell?.circularImageView.image = UIImage(data: data)
		}
		else {
			contentCell?.circularImageView.image = UIImage(named: self.viewModel[(indexPath as NSIndexPath).row].imageName)
		}
		contentCell?.circularImageView.accessibilityLabel = self.viewModel[(indexPath as NSIndexPath).row].primaryHeading
		return contentCell!
	}
	
	@IBAction func newPost(_ sender: AnyObject?) {
		self.routingDelegate?.createNewPost()
	}

}

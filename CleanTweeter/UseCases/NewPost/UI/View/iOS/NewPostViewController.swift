
import UIKit

class NewPostViewController: UIViewController, NewPostView, UITextViewDelegate {
	@IBOutlet weak var countLabel: UILabel!
	@IBOutlet weak var contentTextView: UITextView!
	@IBOutlet weak var avatarImageView: CircularImageView!

	var moduleInterface: NewPostInterface?
	var routingDelegate: NewPostRoutingDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: Selector("done:"))
		self.navigationItem.rightBarButtonItem?.accessibilityIdentifier = "Done"

		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: Selector("cancel:"))
		self.navigationItem.leftBarButtonItem?.accessibilityIdentifier = "Cancel"
		self.automaticallyAdjustsScrollViewInsets = true
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewDidAppear(animated)
		let content = contentTextView.text != nil ? contentTextView.text : ""
		self.moduleInterface?.requestViewForContent(content)
		self.contentTextView.becomeFirstResponder()
	}
	
	func updateView(viewModel: NewPostViewModel) {
		countLabel.text = viewModel.characterCount
		contentTextView.attributedText = viewModel.content
		self.title = viewModel.name
		self.navigationItem.rightBarButtonItem!.enabled = viewModel.canPost
		self.avatarImageView.image = UIImage(named: viewModel.avatar)
	}

	func textViewDidChange(textView: UITextView) {
		self.moduleInterface?.requestViewForContent(textView.text)
	}

	@IBAction func done(sender: AnyObject?) {
		self.moduleInterface?.post()
		self.routingDelegate?.hideNewPostView()
	}

	@IBAction func cancel(sender: AnyObject?) {
		self.routingDelegate?.hideNewPostView()
	}
}

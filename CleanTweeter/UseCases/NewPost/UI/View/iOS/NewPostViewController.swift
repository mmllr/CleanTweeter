
import UIKit

class NewPostViewController: UIViewController, NewPostView, UITextViewDelegate {
	@IBOutlet weak var countLabel: UILabel!
	@IBOutlet weak var contentTextView: UITextView!
	@IBOutlet weak var avatarImageView: CircularImageView!

	var moduleInterface: NewPostInterface?
	var routingDelegate: NewPostRoutingDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(NewPostViewController.done(_:)))
		self.navigationItem.rightBarButtonItem?.accessibilityIdentifier = "Done"

		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(NewPostViewController.cancel(_:)))
		self.navigationItem.leftBarButtonItem?.accessibilityIdentifier = "Cancel"
		self.automaticallyAdjustsScrollViewInsets = true
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		//let content =  != nil ? contentTextView.text : ""
		self.moduleInterface?.requestViewForContent(contentTextView.text ?? "")
		self.contentTextView.becomeFirstResponder()
	}
	
	func updateView(_ viewModel: NewPostViewModel) {
		countLabel.text = viewModel.characterCount
		contentTextView.attributedText = viewModel.content
		self.title = viewModel.name
		self.navigationItem.rightBarButtonItem!.isEnabled = viewModel.canPost
		if let data = try? Data(contentsOf: URL(string: viewModel.avatar)!) {
			self.avatarImageView.image = UIImage(data: data)
		}
		else {
			self.avatarImageView.image = UIImage(named: viewModel.avatar)
		}
	}

	func textViewDidChange(_ textView: UITextView) {
		self.moduleInterface?.requestViewForContent(textView.text)
	}

	@IBAction func done(_ sender: AnyObject?) {
		self.moduleInterface?.post()
		self.routingDelegate?.hideNewPostView()
	}

	@IBAction func cancel(_ sender: AnyObject?) {
		self.routingDelegate?.hideNewPostView()
	}
}

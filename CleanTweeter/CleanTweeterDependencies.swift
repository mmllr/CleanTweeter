
import Foundation
import UIKit

class CleanTweeterDependencies : TweetListRoutingDelegate, NewPostRoutingDelegate {
	let userRepository: DemoUserRepository
	let tweetListWireframe: TweetListWireframe
	let newPostWireframe: NewPostWireframe
	var mainNavigationController: UINavigationController!

	var rootViewController: UIViewController {
		let controller: TweetListTableViewController = self.tweetListWireframe.viewController
		controller.routingDelegate = self
		self.mainNavigationController = UINavigationController(rootViewController: controller)
		return mainNavigationController
	}

	init() {
		userRepository = DemoUserRepository()
		tweetListWireframe = TweetListWireframe(userRepository: userRepository)
		newPostWireframe = NewPostWireframe(userRepository: userRepository)
	}

	func createNewPost() {
		let vc = newPostWireframe.viewController
		vc.routingDelegate = self
		let nav = UINavigationController(rootViewController: vc)
		self.mainNavigationController.presentViewController(nav, animated: true, completion: nil)
	}

	func hideNewPostView() {
		self.mainNavigationController.presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
	}
}

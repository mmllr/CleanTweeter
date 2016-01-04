
import UIKit

class NewPostWireframe {
	var viewController: NewPostViewController {
		let vc = UIStoryboard(name: "NewPost", bundle:nil).instantiateInitialViewController() as! NewPostViewController
		vc.moduleInterface = self.presenter
		self.presenter.view = vc
		return vc
	}
	var presenter: NewPostPresenter
	var interactor: NewPostInteractor

	init(userRepository: UserRepository) {
		self.interactor = NewPostInteractor(repository: userRepository)
		self.presenter = NewPostPresenter(factory: MobileResourceFactory(), userName: "Tim Cook")
		self.interactor.output = self.presenter
		self.presenter.interactor = self.interactor
	}
}

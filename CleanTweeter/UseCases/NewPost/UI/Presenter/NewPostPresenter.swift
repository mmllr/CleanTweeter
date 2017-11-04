
import Foundation

class NewPostPresenter : NewPostInterface, NewPostInteractorOutput {
	var view: NewPostView?
	var interactor: NewPostInteractorInput?
	fileprivate var avatar = ""
	fileprivate var userName = ""
	fileprivate var content = ""
	var resourceFactory: ResourceFactory

	init(factory: ResourceFactory, userName: String) {
		self.resourceFactory = factory
		self.userName = userName
	}
	
	func requestViewForContent(_ content: String) {
		interactor?.requestAvatarForUserName(userName)
		self.content = content

		self.view?.updateView(self.createViewModel())
	}

	func post() {
		self.interactor?.postContent(self.content, forUser: self.userName, publicationDate: Date())
	}
	
	func foundAvatar(_ avatar: String) {
		self.avatar = avatar
		self.view?.updateView(self.createViewModel())
	}

	func createViewModel() -> NewPostViewModel {
		let transformer = TagAndMentionHighlightingTransformer(factory: self.resourceFactory)
		let contentLength = self.content.count
		if contentLength < 160 {
			return NewPostViewModel(name: self.userName, avatar: self.avatar != "" ? self.avatar : "placeholder", content: transformer.transformedValue(self.content) as! NSAttributedString, characterCount: "\(160 - contentLength)", canEdit: true, canPost: contentLength > 0)
		}
		else {
			let substring = String(self.content[..<self.content.index(self.content.startIndex, offsetBy: 160)])
			return NewPostViewModel(name: self.userName, avatar: self.avatar != "" ? self.avatar : "placeholder", content: NSAttributedString(string: substring), characterCount: "0", canEdit: false, canPost: contentLength > 0)
		}
	}
}

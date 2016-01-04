
import Foundation

class TweetListPresenter : TweetListInteractorOutput, TweetListInterface {
	var view: TweetListView?
	var interactor: TweetListInteractorInput?
	var resourceFactory: ResourceFactory
	var highlightingTransformer: TagAndMentionHighlightingTransformer

	init(resourceFactory: ResourceFactory) {
		self.resourceFactory = resourceFactory
		self.highlightingTransformer = TagAndMentionHighlightingTransformer(factory: resourceFactory)
	}

	// MARK: TweetListInterface

	func requestTweetsForUser(userName: String) {
		interactor?.requestTweetsForUserName(userName)
	}

	// MARK: TweetListInteractorOutput

	func foundTweets(tweetlist: [TweetListResponseModel]) {
		let viewModel: [TweetListItem] = tweetlist.map {
			return TweetListItem(primaryHeading: $0.user, secondaryHeading: $0.age, content: self.highlightingTransformer.transformedValue($0.content) as! NSAttributedString, imageName: $0.avatar != "" ? $0.avatar : "placeholder")
		}
		self.view?.updateViewModel(viewModel)
	}
}

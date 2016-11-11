
import Foundation

class TweetListInteractor: TweetListInteractorInput {
	var output: TweetListInteractorOutput?
	var repository: UserRepository
	let dateFormatter: DateComponentsFormatter

	init(repository: UserRepository) {
		self.repository = repository
		let formatter = DateComponentsFormatter()
		formatter.unitsStyle = .abbreviated
		formatter.allowedUnits = [.year, .day, .hour, .minute]
		formatter.maximumUnitCount = 1
		self.dateFormatter = formatter
	}

	func requestTweetsForUserName(_ userName:String) {
		if let user = self.repository.findUser(userName) {
			let followedUserTweets: [[Tweet]] = user.followedUsers.map {
				if let follower = self.repository.findUser($0) {
					return follower.tweets
				}
				return []
			}

			let sortedTweets = (user.tweets + followedUserTweets.flatMap{ $0 }).sorted()

			let result: [TweetListResponseModel] = sortedTweets.map {
				if let avatar = repository.findUser($0.author)?.avatar {
					return TweetListResponseModel(user: $0.author, content: $0.content, age: self.dateFormatter.string(from: $0.publicationDate, to: Date())!, avatar: avatar)
				}
				return TweetListResponseModel(user: $0.author, content: $0.content, age: self.dateFormatter.string(from: $0.publicationDate, to: Date())!, avatar: "")
			}
			output?.foundTweets(result)
		}
	}
}


import Foundation

class NewPostInteractor : NewPostInteractorInput {
	var repository: UserRepository
	var output: NewPostInteractorOutput?

	init(repository: UserRepository) {
		self.repository = repository
	}

	func postContent(content: String, forUser: String, publicationDate: NSDate) {
		if let user = repository.findUser(forUser) {
			var tweets = user.tweets
			tweets.append(Tweet(author: user.name, content: content, publicationDate: publicationDate))
			let newUser = User(name: user.name, followedUsers: user.followedUsers, tweets:tweets, avatar: user.avatar)
			repository.updateUser(newUser)
		}
	}

	func requestAvatarForUserName(userName: String) {
		if let user = repository.findUser(userName) {
			self.output?.foundAvatar(user.avatar)
		}
	}
}

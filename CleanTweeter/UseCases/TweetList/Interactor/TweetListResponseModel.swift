
import Foundation

struct TweetListResponseModel : Equatable {
	let user: String
	let content: String
	let age: String
	let avatar: String
}

func ==(lhs: TweetListResponseModel, rhs: TweetListResponseModel) -> Bool {
	if lhs.user != rhs.user {
		return false
	}
	if lhs.content != rhs.content {
		return false
	}
	if lhs.age != rhs.age {
		return false
	}
	return lhs.avatar == rhs.avatar
}



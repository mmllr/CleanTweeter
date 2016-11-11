
import Foundation

struct TweetListItem : Equatable {
	var primaryHeading: String
	var secondaryHeading: String
	var content: NSAttributedString
	var imageName: String = ""
}

func==(lhs: TweetListItem, rhs: TweetListItem) -> Bool {
	if lhs.primaryHeading != rhs.primaryHeading {
		return false
	}
	if lhs.secondaryHeading != rhs.secondaryHeading {
		return false
	}
	if !lhs.content.isEqual(to: rhs.content) {
		return false
	}
	return lhs.imageName == rhs.imageName
}

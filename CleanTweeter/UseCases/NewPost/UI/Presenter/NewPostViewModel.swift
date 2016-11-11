
import Foundation

struct NewPostViewModel : Equatable {
	var name: String
	var avatar: String
	var content: NSAttributedString
	var characterCount: String
	var canEdit: Bool
	var canPost: Bool
}

func==(lhs: NewPostViewModel, rhs: NewPostViewModel) -> Bool {
	if lhs.canEdit != rhs.canEdit {
		return false
	}
	if lhs.canPost != rhs.canPost {
		return false
	}
	if lhs.name != rhs.name {
		return false
	}
	if lhs.avatar != rhs.avatar {
		return false
	}
	if !lhs.content.isEqual(to: rhs.content) {
		return false
	}
	return lhs.characterCount == rhs.characterCount
}

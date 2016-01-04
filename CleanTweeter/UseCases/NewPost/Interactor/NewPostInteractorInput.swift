
import Foundation

protocol NewPostInteractorInput {
	func postContent(content: String, forUser: String, publicationDate: NSDate)
	func requestAvatarForUserName(userName: String)
}


import Foundation

protocol NewPostInteractorInput {
	func postContent(_ content: String, forUser: String, publicationDate: Date)
	func requestAvatarForUserName(_ userName: String)
}

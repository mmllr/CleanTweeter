
import Foundation

protocol UserRepository {
	func findUser(userName: String) -> User?
	func updateUser(user: User)
}

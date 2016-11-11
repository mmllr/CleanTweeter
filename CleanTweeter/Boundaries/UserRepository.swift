
import Foundation

protocol UserRepository {
	func findUser(_ userName: String) -> User?
	func updateUser(_ user: User)
}

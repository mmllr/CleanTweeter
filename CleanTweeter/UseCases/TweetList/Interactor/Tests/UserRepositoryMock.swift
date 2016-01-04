
import Foundation
#if os(iOS)
@testable import CleanTweeter
#else
@testable import CleanTweeterMac
#endif

class UserRepositoryMock : UserRepository {
	var store: Dictionary<String, User> = [:]

	func  findUser(userName: String) -> User? {
		return store[userName]
	}

	func updateUser(user: User) {
	}

	func givenTheUsers(users: [User]) {
		for user in users {
			store[user.name] = user
		}
	}
}

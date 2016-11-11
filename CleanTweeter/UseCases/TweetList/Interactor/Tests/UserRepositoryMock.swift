
import Foundation
#if os(iOS)
@testable import CleanTweeter
#else
@testable import CleanTweeterMac
#endif

class UserRepositoryMock : UserRepository {
	var store: Dictionary<String, User> = [:]

	func  findUser(_ userName: String) -> User? {
		return store[userName]
	}

	func updateUser(_ user: User) {
	}

	func givenTheUsers(_ users: [User]) {
		for user in users {
			store[user.name] = user
		}
	}
}

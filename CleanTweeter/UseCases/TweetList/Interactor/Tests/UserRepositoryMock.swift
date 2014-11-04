//
//  UserRepositoryMock.swift
//  CleanTweeter
//
//  Created by Markus Müller on 30.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation
#if os(iOS)
import CleanTweeter
#else
import CleanTweeterMac
#endif

class UserRepositoryMock : UserRepository {
	var store: Dictionary<String, User> = [:]

	func  findUser(userName: String) -> User? {
		return store[userName]
	}

	func givenTheUsers(users: [User]) {
		for user in users {
			store[user.name] = user
		}
	}
}

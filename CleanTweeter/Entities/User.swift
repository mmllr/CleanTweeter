//
//  User.swift
//  CleanTweeter
//
//  Created by Markus Müller on 30.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

struct User : Equatable {
	let name: String
	let followedUsers: [String]
	let tweets: [Tweet]
	let avatar: String

	init(name: String, followedUsers: [String], tweets: [Tweet], avatar: String = "") {
		self.name = name
		self.followedUsers = Set<String>(followedUsers).filter {
			$0 != name
		}.sorted()
		self.tweets = tweets
		self.avatar = avatar
	}
}

func ==(lhs: User, rhs: User) -> Bool {
	if lhs.name != rhs.name {
		return false
	}
	if lhs.followedUsers != rhs.followedUsers {
		return false
	}
	if lhs.avatar != rhs.avatar {
		return false
	}
	return lhs.tweets == rhs.tweets
}

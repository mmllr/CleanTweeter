//
//  User.swift
//  CleanTweeter
//
//  Created by Markus Müller on 30.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

struct User {
	let name: String
	let followedUsers: [String]
	let tweets: [Tweet]
	let avatar: String

	init(name: String, followedUsers: [String], tweets: [Tweet], avatar: String = "") {
		self.name = name
		self.followedUsers = Set(followedUsers).filter {
			$0 != name
		}.sort()
		self.tweets = tweets
		self.avatar = avatar
	}
}

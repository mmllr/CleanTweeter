//
//  User.swift
//  CleanTweeter
//
//  Created by Markus Müller on 30.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

public class User {
	public let name: String
	public let followedUsers: [String]
	public let tweets: [Tweet]

	public init(name: String, followedUsers: [String], tweets: [Tweet]) {
		self.name = name
		self.followedUsers = unique(followedUsers).sort().filter {
			$0 != name
		}
		self.tweets = tweets
	}
}

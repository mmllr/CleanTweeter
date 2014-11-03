//
//  DemoUserRepository.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

class DemoUserRepository : UserRepository {
	var store: Dictionary<String, User> = [:]

	init() {
		let users = [
			User(name: "Tim Cook", followedUsers: ["Jony Ive", "Craig Ferdighi", "Eddy Cue"], tweets: [
				Tweet(author: "Tim Cook", content: "Super awesome!", publicationDate: NSDate()),
				Tweet(author: "Tim Cook", content: "Incredible!", publicationDate: NSDate()),
				Tweet(author: "Tim Cook", content: "Only Apple can do this!", publicationDate: NSDate())
				]),
			User(name: "Craig Ferdighi", followedUsers: ["Tim Cook", "Jony Ive"], tweets: [
				Tweet(author: "Craig Ferdighi", content: "Forever hairforce #1", publicationDate: NSDate())
				]),
			User(name: "Jony Ive", followedUsers: ["Tim Cook"], tweets: [
				Tweet(author: "Jony Ive", content: "Aluminum!", publicationDate: NSDate()),
				Tweet(author: "Jony Ive", content: "Sire!", publicationDate: NSDate()),
				]),
			User(name: "Eddy Cue", followedUsers: ["Tim Cook", "Jony Ive", "Craig Ferdighi"], tweets: [
				Tweet(author: "Eddy Cue", content: "Lets change the iTunes UI", publicationDate: NSDate()),
				Tweet(author: "Eddy Cue", content: "AppleTV FTW!", publicationDate: NSDate()),
				])
		]
		for user in users {
			store[user.name] = user
		}
	}

	func findUser(userName: String) -> User? {
		return store[userName]
	}
}
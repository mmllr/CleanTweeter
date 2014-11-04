//
//  DemoUserRepository.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

func createUsers() -> [User] {
	let dateFormatter = NSDateFormatter()
	dateFormatter.timeStyle = .NoStyle
	dateFormatter.dateStyle = .FullStyle
	dateFormatter.dateFormat = "yyyy.MM.dd"

	let users = [
		User(name: "Tim Cook", followedUsers: ["Jony Ive", "Craig Ferdighi", "Eddy Cue"], tweets: [
			Tweet(author: "Tim Cook", content: "Super awesome!", publicationDate: dateFormatter.dateFromString("2014.09.12")!),
			Tweet(author: "Tim Cook", content: "Incredible!", publicationDate: dateFormatter.dateFromString("2014.11.3")!),
			Tweet(author: "Tim Cook", content: "Only #Apple can do this!", publicationDate: dateFormatter.dateFromString("2014.11.2")!)
			]),
		User(name: "Craig Ferdighi", followedUsers: ["Tim Cook", "Jony Ive"], tweets: [
			Tweet(author: "Craig Ferdighi", content: "Forever #hairforceone", publicationDate: dateFormatter.dateFromString("2014.10.29")!),
			Tweet(author: "Craig Ferdighi", content: "@Jony leather UI?", publicationDate:dateFormatter.dateFromString("2014.11.1")!)
			]),
		User(name: "Jony Ive", followedUsers: ["Tim Cook"], tweets: [
			Tweet(author: "Jony Ive", content: "Aluminum!", publicationDate: dateFormatter.dateFromString("2014.10.30")!),
			Tweet(author: "Jony Ive", content: "Sire!", publicationDate: dateFormatter.dateFromString("2014.11.1")!),
			]),
		User(name: "Eddy Cue", followedUsers: ["Tim Cook", "Jony Ive", "Craig Ferdighi"], tweets: [
			Tweet(author: "Eddy Cue", content: "Lets change the #iTunes UI", publicationDate: dateFormatter.dateFromString("2014.08.3")!),
			Tweet(author: "Eddy Cue", content: "AppleTV #FTW!", publicationDate: dateFormatter.dateFromString("2012.10.3")!),
			])
	]
	return users
}

class DemoUserRepository : UserRepository {
	var store: Dictionary<String, User> = [:]

	init() {
		for user in createUsers() {
			store[user.name] = user
		}
	}

	func findUser(userName: String) -> User? {
		return store[userName]
	}
}
//
//  TweetListInteractor.swift
//  CleanTweeter
//
//  Created by Markus Müller on 29.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

class TweetListInteractor: TweetListInteractorInput {
	var output: TweetListInteractorOutput?
	var repository: UserRepository
	let dateFormatter: NSDateComponentsFormatter

	init(repository: UserRepository) {
		self.repository = repository
		let formatter = NSDateComponentsFormatter()
		formatter.unitsStyle = .Abbreviated
		formatter.allowedUnits = [.Year, .Day, .Hour, .Minute]
		formatter.maximumUnitCount = 1
		self.dateFormatter = formatter
	}

	func requestTweetsForUserName(userName:String) {
		if let user = self.repository.findUser(userName) {
			let followedUserTweets: [[Tweet]] = user.followedUsers.map {
				if let follower = self.repository.findUser($0) {
					return follower.tweets
				}
				return []
			}

			let sortedTweets = (user.tweets + followedUserTweets.flatMap{ $0 }).sort()

			let result: [TweetListResponseModel] = sortedTweets.map {
				if let avatar = repository.findUser($0.author)?.avatar {
					return TweetListResponseModel(user: $0.author, content: $0.content, age: self.dateFormatter.stringFromDate($0.publicationDate, toDate: NSDate())!, avatar: avatar)
				}
				return TweetListResponseModel(user: $0.author, content: $0.content, age: self.dateFormatter.stringFromDate($0.publicationDate, toDate: NSDate())!, avatar: "")
			}
			output?.foundTweets(result)
		}
	}
}

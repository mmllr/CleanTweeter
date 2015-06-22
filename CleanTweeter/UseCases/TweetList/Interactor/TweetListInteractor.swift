//
//  TweetListInteractor.swift
//  CleanTweeter
//
//  Created by Markus Müller on 29.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

public class TweetListInteractor: TweetListInteractorInput {
	public var output: TweetListInteractorOutput?
	var repository: UserRepository
	let dateFormatter: NSDateComponentsFormatter

	public init(repository: UserRepository) {
		self.repository = repository
		let formatter = NSDateComponentsFormatter()
		formatter.unitsStyle = .Abbreviated
		formatter.allowedUnits = [.Year, .Day, .Hour, .Minute]
		formatter.maximumUnitCount = 1
		self.dateFormatter = formatter
	}

	public func requestTweetsForUserName(userName:String) {
		if let user = self.repository.findUser(userName) {
			let followedUserTweets: [Tweet] = flatten(user.followedUsers.map {
				if let follower = self.repository.findUser($0) {
					return follower.tweets
				}
				return []
			})

			let sortedTweets = (user.tweets + followedUserTweets).sort()

			let result: [TweetListResponseModel] = sortedTweets.map {
				TweetListResponseModel(user: $0.author, content: $0.content, age: self.dateFormatter.stringFromDate($0.publicationDate, toDate: NSDate())!)
			}
			output?.foundTweets(result)
		}
	}
}

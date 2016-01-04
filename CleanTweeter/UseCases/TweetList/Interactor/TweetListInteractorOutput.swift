//
//  TweetListInteractorOutput.swift
//  CleanTweeter
//
//  Created by Markus Müller on 29.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

protocol TweetListInteractorOutput {
	func foundTweets(tweetlist: [TweetListResponseModel])
}

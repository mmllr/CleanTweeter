//
//  TweetListResponseModel.swift
//  CleanTweeter
//
//  Created by Markus Müller on 29.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

public struct TweetListResponseModel : Equatable {
	public let user: String
	public let content: String
	public let age: String

	public init(user: String, content: String, age: String) {
		self.user = user
		self.content = content
		self.age = age
	}
}

public func ==(lhs: TweetListResponseModel, rhs: TweetListResponseModel) -> Bool {
	if lhs.user != rhs.user {
		return false
	}
	if lhs.content != rhs.content {
		return false
	}
	if lhs.age != rhs.age {
		return false
	}
	return true
}



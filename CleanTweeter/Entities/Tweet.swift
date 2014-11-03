//
//  Tweet.swift
//  CleanTweeter
//
//  Created by Markus Müller on 30.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

public class Tweet : Comparable {
	public let author: String
	public let content: String
	public let publicationDate: NSDate

	public init(author: String, content: String, publicationDate: NSDate = NSDate()) {
		self.author = author
		if countElements(content) > 160 {
			self.content = content.substringToIndex(advance(content.startIndex, 160))
		}
		else {
			self.content = content
		}
		self.publicationDate = publicationDate.timeIntervalSinceNow > 0 ? NSDate() : publicationDate
	}
}

public func ==(lhs: Tweet, rhs: Tweet) -> Bool {
	if lhs.author != rhs.author {
		return false
	}
	if lhs.content != rhs.content {
		return false
	}
	return lhs.publicationDate.isEqualToDate(rhs.publicationDate)
}

public func <(lhs: Tweet, rhs: Tweet) -> Bool {
	return lhs.publicationDate.compare(rhs.publicationDate) == .OrderedDescending
}

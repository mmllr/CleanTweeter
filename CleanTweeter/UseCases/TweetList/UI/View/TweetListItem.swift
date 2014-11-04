//
//  TweetListItem.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

public struct TweetListItem : Equatable {
	public var primaryHeading: String
	public var secondaryHeading: String
	public var content: NSAttributedString

	public init(primaryHeading: String, secondaryHeading: String, content: NSAttributedString) {
		self.primaryHeading = primaryHeading
		self.secondaryHeading = secondaryHeading
		self.content = content
	}
}

public func==(lhs: TweetListItem, rhs: TweetListItem) -> Bool {
	if lhs.primaryHeading != rhs.primaryHeading {
		return false
	}
	if lhs.secondaryHeading != rhs.secondaryHeading {
		return false
	}
	return lhs.content.isEqualToAttributedString(rhs.content)
}

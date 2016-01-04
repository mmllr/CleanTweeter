//
//  TweetListItem.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

struct TweetListItem : Equatable {
	var primaryHeading: String
	var secondaryHeading: String
	var content: NSAttributedString
	var imageName: String
}

func==(lhs: TweetListItem, rhs: TweetListItem) -> Bool {
	if lhs.primaryHeading != rhs.primaryHeading {
		return false
	}
	if lhs.secondaryHeading != rhs.secondaryHeading {
		return false
	}
	if !lhs.content.isEqualToAttributedString(rhs.content) {
		return false
	}
	return lhs.imageName == rhs.imageName
}

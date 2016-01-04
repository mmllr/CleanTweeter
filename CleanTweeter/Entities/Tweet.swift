//
//  Tweet.swift
//  CleanTweeter
//
//  Created by Markus Müller on 30.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

struct Tweet : Comparable {
	let author: String
	let content: String
	let publicationDate: NSDate
	let mentionedUsers: [String]
	let tags: [String]

	init(author: String, content: String, publicationDate: NSDate = NSDate()) {
		self.author = author
		self.content = content.characters.count > 160 ? content.substringToIndex(content.startIndex.advancedBy(160)) : content
		self.publicationDate = publicationDate.timeIntervalSinceNow > 0 ? NSDate() : publicationDate
		self.mentionedUsers = findMentions(self.content)
		self.tags = findTags(self.content)
	}
}

func findMentions(text: String) -> [String] {
	let ranges = text.findRangesWithPattern("(@([A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)_]+))")

	return unique(ranges.map {
		return text.substringWithRange($0)
	})
}

func findTags(text: String) -> [String] {
	let ranges = text.findRangesWithPattern("(#([A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)_]+))")
	
	return unique(ranges.map {
		return text.substringWithRange($0)
		})
}

func ==(lhs: Tweet, rhs: Tweet) -> Bool {
	if lhs.author != rhs.author {
		return false
	}
	if lhs.content != rhs.content {
		return false
	}
	return lhs.publicationDate.isEqualToDate(rhs.publicationDate)
}

func <(lhs: Tweet, rhs: Tweet) -> Bool {
	return lhs.publicationDate.compare(rhs.publicationDate) == .OrderedDescending
}

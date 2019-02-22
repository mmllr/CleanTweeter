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
	let publicationDate: Date
	let mentionedUsers: [String]
	let tags: [String]

	init(author: String, content: String, publicationDate: Date = Date()) {
		self.author = author
		self.content = content.count > 160 ? String(content[..<content.index(content.startIndex, offsetBy: 160)]) : content
		self.publicationDate = publicationDate.timeIntervalSinceNow > 0 ? Date() : publicationDate
		self.mentionedUsers = findMentions(self.content)
		self.tags = findTags(self.content)
	}
}

func findMentions(_ text: String) -> [String] {
	let ranges = text.findRangesWithPattern("(@([A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)_]+))")
	return unique(ranges.map {
		return String(text[$0.lowerBound..<$0.upperBound])
	})
}

func findTags(_ text: String) -> [String] {
	let ranges = text.findRangesWithPattern("(#([A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)_]+))")

	return unique(ranges.map {
		return String(text[$0.lowerBound..<$0.upperBound])
	})
}

func ==(lhs: Tweet, rhs: Tweet) -> Bool {
	if lhs.author != rhs.author {
		return false
	}
	if lhs.content != rhs.content {
		return false
	}
	return (lhs.publicationDate == rhs.publicationDate)
}

func <(lhs: Tweet, rhs: Tweet) -> Bool {
	return lhs.publicationDate.compare(rhs.publicationDate) == .orderedDescending
}

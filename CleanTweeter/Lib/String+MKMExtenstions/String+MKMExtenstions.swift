//
//  String+MKMExtenstions.swift
//  CleanTweeter
//
//  Created by Markus Müller on 04.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

extension String {
	func findRangesWithPattern(pattern: String) -> [Range<String.Index>] {
		
		do {
			let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
			return regex.matchesInString(self, options: .ReportCompletion, range: NSMakeRange(0, self.characters.count)).map {
				let start = startIndex.advancedBy($0.range.location)
				let end = self.startIndex.advancedBy(NSMaxRange($0.range))
				return Range(start: start, end: end)
			}
		} catch _ {
			return []
		}
	}
}

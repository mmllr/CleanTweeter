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
		let regex = NSRegularExpression(pattern: pattern, options: .CaseInsensitive, error: nil)
		
		if let ranges = regex?.matchesInString(self, options: .ReportCompletion, range: NSMakeRange(0, countElements(self))) {
			return ranges.map {
				let start = advance(self.startIndex, $0.range.location)
				let end = advance(self.startIndex, NSMaxRange($0.range))
				return Range(start: start, end: end)
			}
		}
		return []
	}
}

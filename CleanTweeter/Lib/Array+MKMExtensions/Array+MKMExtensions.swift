//
//  Array+MKMExtensions.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

public func unique<T: Hashable>(_ array: [T]) -> [T] {
	var uniqueValues: Set<T> = Set();

	return array.filter {
		if !(uniqueValues.contains($0)) {
			uniqueValues.insert($0)
			return true
		}
		return false
	}
}

//
//  Array+MKMExtensions.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

public func flatten<T>(array: [[T]]) -> [T] {
	return array.reduce([]) { $0 + $1 }
}

public func unique<T: Hashable>(array: [T]) -> [T] {
	var uniqueValues: [T:Bool] = [:]

	return array.filter {
		if !(uniqueValues[$0] != nil) {
			uniqueValues[$0] = true
			return true
		}
		return false
	}
}

//
//  Array+MKMExtensionsTests.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import XCTest
#if os(iOS)
import CleanTweeter
#else
import CleanTweeterMac
#endif

class Array_MKMExtensionsTests: XCTestCase {

	func testThatAnArrayOfArraysCanBeFlattened() {
		let arrayOfArraysOfNumbers = [[1, 2, 3], [4, 5]]

		XCTAssertEqual(flatten(arrayOfArraysOfNumbers), [1, 2, 3, 4, 5])

		let arrayOfArrayOfStrings = [["one", "two"], ["three"], ["four", "five", "six"]]

		XCTAssertEqual(flatten(arrayOfArrayOfStrings), ["one", "two", "three", "four", "five", "six"])
	}

	func testThatAnArrayCanBeUniqued() {
		let array = [1, 1, 2, 4, 6, 7, 6, 8, 8, 9]

		XCTAssertEqual(unique(array), [1, 2, 4, 6, 7, 8, 9])

		let strings = ["one", "two", "one", "three"]

		XCTAssertEqual(unique(strings), ["one", "two", "three"])
	}
}

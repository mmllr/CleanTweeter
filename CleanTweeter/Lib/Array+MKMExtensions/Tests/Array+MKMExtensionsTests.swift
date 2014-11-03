//
//  Array+MKMExtensionsTests.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import XCTest
import CleanTweeter

class Array_MKMExtensionsTests: XCTestCase {

	func testThatAnArrayOfArraysCanBeFlattened() {
		let arrayOfArraysOfNumbers = [[1, 2, 3], [4, 5]]

		XCTAssertEqual(flatten(arrayOfArraysOfNumbers), [1, 2, 3, 4, 5])

		let arrayOfArrayOfStrings = [["one", "two"], ["three"], ["four", "five", "six"]]

		XCTAssertEqual(flatten(arrayOfArrayOfStrings), ["one", "two", "three", "four", "five", "six"])
	}
}

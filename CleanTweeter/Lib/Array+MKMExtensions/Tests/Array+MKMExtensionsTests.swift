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

	func testThatAnArrayCanBeUniqued() {
		let array = [1, 1, 2, 4, 6, 7, 6, 8, 8, 9]

		XCTAssertEqual(unique(array), [1, 2, 4, 6, 7, 8, 9])

		let strings = ["one", "two", "one", "three"]

		XCTAssertEqual(unique(strings), ["one", "two", "three"])
	}
}

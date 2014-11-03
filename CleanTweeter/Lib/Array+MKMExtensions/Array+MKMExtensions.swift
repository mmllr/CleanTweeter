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

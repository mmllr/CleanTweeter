//
//  ResourceFactory.swift
//  CleanTweeter
//
//  Created by Markus Müller on 04.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

public protocol ResourceFactory {
	var highlightingAttribute: (String, AnyObject) { get }
}

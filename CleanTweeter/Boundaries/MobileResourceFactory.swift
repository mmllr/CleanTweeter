//
//  MobileResourceFactory.swift
//  CleanTweeter
//
//  Created by Markus Müller on 04.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation
import UIKit

public class MobileResourceFactory : ResourceFactory {
	public var highlightingAttribute: (String, AnyObject)

	public init() {
		highlightingAttribute = (NSForegroundColorAttributeName, UIColor.blueColor())
	}
}

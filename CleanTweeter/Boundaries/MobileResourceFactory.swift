//
//  MobileResourceFactory.swift
//  CleanTweeter
//
//  Created by Markus Müller on 04.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation
import UIKit

class MobileResourceFactory : ResourceFactory {
	var highlightingAttribute: (String, AnyObject)

	init() {
		highlightingAttribute = (NSForegroundColorAttributeName, UIColor.blueColor())
	}
}

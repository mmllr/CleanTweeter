//
//  CleanTweeterDependenciesMac.swift
//  CleanTweeter
//
//  Created by Markus Müller on 04.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation
import Cocoa

class CleanTweeterDependenciesMac {
	let userRepository: DemoUserRepository
	let tweetListWireframe: TweetListWireframeMac

	init() {
		userRepository = DemoUserRepository()
		tweetListWireframe = TweetListWireframeMac(userRepository: userRepository)
	}

	func showWindow() {
		tweetListWireframe.windowController.showWindow(self)
	}
}

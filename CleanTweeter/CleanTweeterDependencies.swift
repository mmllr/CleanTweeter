//
//  CleanTweeterDependencies.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation
import UIKit

class CleanTweeterDependencies {
	let userRepository: DemoUserRepository
	let tweetListWireframe: TweetListWireframe
	var rootViewController: UIViewController {
		return UINavigationController(rootViewController: self.tweetListWireframe.viewController)
	}
	
	init() {
		userRepository = DemoUserRepository()
		tweetListWireframe = TweetListWireframe(userRepository: userRepository)
	}
}

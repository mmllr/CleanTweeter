//
//  AppDelegate.swift
//  CleanTweeter
//
//  Created by Markus Müller on 29.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var dependencies: CleanTweeterDependencies

	override init() {
		dependencies = CleanTweeterDependencies()
		window = UIWindow(frame: UIScreen.mainScreen().bounds)
	}

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		window?.rootViewController = dependencies.rootViewController
		return true
	}

	func applicationWillResignActive(application: UIApplication) {
	}

	func applicationDidEnterBackground(application: UIApplication) {
	}

	func applicationWillEnterForeground(application: UIApplication) {
	}

	func applicationDidBecomeActive(application: UIApplication) {
	}

	func applicationWillTerminate(application: UIApplication) {
	}


}


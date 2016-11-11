//
//  AppDelegate.swift
//  CleanTweeterMac
//
//  Created by Markus Müller on 04.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	var dependencies: CleanTweeterDependenciesMac

	override init() {
		dependencies = CleanTweeterDependenciesMac()
	}
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		dependencies.showWindow()
	}

	func applicationWillTerminate(_ aNotification: Notification) {
	}

	func applicationShouldTerminateAfterLastWindowClosed(_ theApplication: NSApplication) -> Bool {
		return true
	}
}


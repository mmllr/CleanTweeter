//
//  TweetListView.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

public protocol TweetListView {
	func updateViewModel(_ : [TweetListItem])
}

//
//  TweetListPresenter.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

class TweetListPresenter : TweetListInteractorOutput, TweetListInterface {
	var view: TweetListView?
	var interactor: TweetListInteractorInput?
	var resourceFactory: ResourceFactory

	init(resourceFactory: ResourceFactory) {
		self.resourceFactory = resourceFactory
	}

	// MARK: TweetListInterface

	func requestTweetsForUser(userName: String) {
		interactor?.requestTweetsForUserName(userName)
	}

	// MARK: TweetListInteractorOutput

	func foundTweets(tweetlist: [TweetListResponseModel]) {
		let viewModel: [TweetListItem] = tweetlist.map {
			return TweetListItem(primaryHeading: $0.user, secondaryHeading: $0.age, content: self.attributeContent($0.content), imageName: $0.avatar != "" ? $0.avatar : "placeholder")
		}
		self.view?.updateViewModel(viewModel)
	}

	func attributeContent(content: String) -> NSAttributedString {
		return content.findRangesWithPattern("((@|#)([A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)_]+))|(http(s)?://([A-Z0-9a-z._-]*(/)?)*)").reduce(NSMutableAttributedString(string: content)) {
			let string = $0
			let range = NSMakeRange(content.startIndex.distanceTo($1.startIndex), $1.count)
			let attribute = self.resourceFactory.highlightingAttribute
			string.addAttribute(attribute.0, value: attribute.1, range: range)
			return string
		}
	}

}

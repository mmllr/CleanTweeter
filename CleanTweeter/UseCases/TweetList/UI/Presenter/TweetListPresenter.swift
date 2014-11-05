//
//  TweetListPresenter.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

public class TweetListPresenter : TweetListInteractorOutput, TweetListInterface {
	public var view: TweetListView?
	public var interactor: TweetListInteractorInput?
	var resourceFactory: ResourceFactory

	public init(resourceFactory: ResourceFactory) {
		self.resourceFactory = resourceFactory
	}

	// MARK: TweetListInterface

	public func requestTweetsForUser(userName: String) {
		interactor?.requestTweetsForUserName(userName)
	}

	// MARK: TweetListInteractorOutput

	public func foundTweets(tweetlist: [TweetListResponseModel]) {
		let viewModel: [TweetListItem] = tweetlist.map {
			return TweetListItem(primaryHeading: $0.user, secondaryHeading: $0.age, content: self.attributeContent($0.content))
		}
		self.view?.updateViewModel(viewModel)
	}

	func attributeContent(content: String) -> NSAttributedString {
		return content.findRangesWithPattern("((@|#)([A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)_]+))|(http(s)?://([A-Z0-9a-z._-]*(/)?)*)").reduce(NSMutableAttributedString(string: content)) {
			let string = $0
			let range = NSMakeRange(distance(content.startIndex, $1.startIndex), countElements($1))
			let attribute = self.resourceFactory.highlightingAttribute
			string.addAttribute(attribute.0, value: attribute.1, range: range)
			return string
		}
	}

}

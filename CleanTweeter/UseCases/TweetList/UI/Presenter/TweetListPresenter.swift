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

	public init() {

	}

	public func requestTweetsForUser(userName: String) {
		interactor?.requestTweetsForUserName(userName)
	}
	
	public func foundTweets(tweetlist: [TweetListResponseModel]) {
		let viewModel: [TweetListItem] = tweetlist.map {
			return TweetListItem(primaryHeading: $0.user, secondaryHeading: $0.age, content: $0.content)
		}
		self.view?.updateViewModel(viewModel)
	}

}

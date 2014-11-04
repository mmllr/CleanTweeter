//
//  TweetListWireframe.swift
//  CleanTweeter
//
//  Created by Markus Müller on 04.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

public class TweetListWireframe {
	public let windowController: TweetListWindowController
	public let interactor: TweetListInteractor
	public let presenter: TweetListPresenter
	
	public init(userRepository: UserRepository) {
		interactor = TweetListInteractor(repository: userRepository)
		presenter = TweetListPresenter(resourceFactory: OSXResourceFactory())
		interactor.output = presenter
		presenter.interactor = interactor
		windowController = TweetListWindowController(windowNibName: "TweetListWindow")
		windowController.moduleInterface = presenter
		presenter.view = windowController
	}
}

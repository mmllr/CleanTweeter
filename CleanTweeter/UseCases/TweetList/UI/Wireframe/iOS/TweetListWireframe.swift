//
//  TweetListWireframe.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation
import UIKit

class TweetListWireframe {
	let viewController: TweetListTableViewController
	let interactor: TweetListInteractor
	let presenter: TweetListPresenter

	init(userRepository: UserRepository) {
		viewController = UIStoryboard(name: "TweetList", bundle:nil).instantiateInitialViewController() as! TweetListTableViewController

		interactor = TweetListInteractor(repository: userRepository)
		presenter = TweetListPresenter(resourceFactory: MobileResourceFactory())
		interactor.output = presenter
		presenter.view = viewController
		presenter.interactor = interactor
		viewController.moduleInterface = presenter
	}
}

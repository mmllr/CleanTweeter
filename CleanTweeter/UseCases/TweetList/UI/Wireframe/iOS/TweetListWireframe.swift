//
//  TweetListWireframe.swift
//  CleanTweeter
//
//  Created by Markus Müller on 03.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation
import UIKit

public class TweetListWireframe {
	public let viewController: TweetListTableViewController
	public let interactor: TweetListInteractor
	public let presenter: TweetListPresenter

	public init(userRepository: UserRepository) {
		viewController = UIStoryboard(name: "TweetList", bundle:nil).instantiateInitialViewController() as TweetListTableViewController

		interactor = TweetListInteractor(repository: userRepository)
		presenter = TweetListPresenter()
		interactor.output = presenter
		presenter.view = viewController
		presenter.interactor = interactor
		viewController.moduleInterface = presenter
	}
}

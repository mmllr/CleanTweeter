//
//  UserRepository.swift
//  CleanTweeter
//
//  Created by Markus Müller on 30.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation

protocol UserRepository {
	func findUser(userName: String) -> User?
}

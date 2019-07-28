//
//  ErrorResult.swift
//  DogApp
//
//  Created by Ebin Joy on 28/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}

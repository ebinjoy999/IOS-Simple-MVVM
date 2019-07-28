//
//  Result.swift
//  DogApp
//
//  Created by Ebin Joy on 28/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}

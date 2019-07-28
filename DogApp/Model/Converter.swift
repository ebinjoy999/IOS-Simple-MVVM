//
//  DogList.swift
//  CheckinList1
//
//  Created by Ebin Joy on 21/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import Foundation
struct Converter{
    var type: ListType?
    var dogs: [Dog] = [Dog]()
    init(json :Data) {
        do {
            let decoder = JSONDecoder()
             let dogs = try decoder.decode([Dog].self, from: json)
            self.dogs = dogs
        } catch let parsingError {
            print("Error", parsingError)
        }
    }
}

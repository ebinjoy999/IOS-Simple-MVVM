//
//  Dog.swift
//  CheckinList1
//
//  Created by Ebin Joy on 21/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import Foundation


struct Dog: Codable{
    var breeds :[Breed]?
    var id :String
    var url :String?
    var width: Int?
    var height: Int?
    
}

struct Breed : Codable{
    var id :Int
    var name: String?
    var bred_for: String?
    var breed_group: String?
    var life_span: String?
    var temperament: String?
    var origin_country: String?
    var weight: Weight?

    enum CodingKeys: String, CodingKey {
        case id, name,bred_for,breed_group,life_span,temperament,weight
        case origin_country = "origin"
    }
}

struct Weight: Codable {
    var imperial :String
    var metric :String
    
    enum CodingKeys: String, CodingKey {
        case imperial, metric
    }
}

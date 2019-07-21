//
//  DogCell.swift
//  DogApp
//
//  Created by Ebin Joy on 22/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import Foundation
import UIKit

class DogCell: UITableViewCell{
    
    @IBOutlet weak var dogName: UILabel!
    @IBOutlet weak var dogBrred: UILabel!
    @IBOutlet weak var dogLifeSapn: UILabel!
    
    func loadData(_ dog: Dog){
        
        if (dog.breeds?.count)! > 0 {
            dogName.text = dog.breeds![0].name?.capitalized
            dogBrred.text = dog.breeds![0].breed_group
            dogLifeSapn.text = dog.breeds![0].life_span
        }else{
           dogName.text = "No breeds found!"
            dogBrred.text = ""
            dogLifeSapn.text = ""
        }
        
        
        
    }
}

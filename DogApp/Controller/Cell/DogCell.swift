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
    @IBOutlet weak var uiImage: UIImageView!
    
    func loadData(_ viewModel:DogVIewModel, _ dog: Dog, _ tag:Int){
        
        if (dog.breeds?.count)! > 0 {
            dogName.text = dog.breeds![0].name?.capitalized
            dogBrred.text = dog.breeds![0].breed_group
            dogLifeSapn.text = dog.breeds![0].life_span
        }else{
           dogName.text = "No breeds found!"
            dogBrred.text = ""
            dogLifeSapn.text = ""
        }
        self.uiImage.isHidden = true
        self.uiImage.image = nil
        if dog.url != nil{
            self.uiImage.tag = tag
            viewModel.downloadImage(tag,CGSize(width: uiImage.frame.width,
                                           height: uiImage.frame.height),
                                    url: dog.url!, completion:{ [weak self]
                (response, row) in
                guard self != nil else {
                return
                }
                    DispatchQueue.main.async {
                        if  self?.uiImage.tag == row {
                          self?.uiImage.isHidden = false
                          self?.uiImage.image = response
                        }
                    }
            })
        }
    }
}

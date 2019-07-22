//
//  DetailViewController.swift
//  DogApp
//
//  Created by Ebin Joy on 22/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {

    var dataDog: Dog?
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var dogVIewModel: DogVIewModel?
    
    override func viewDidLoad() {
        dogVIewModel = DogVIewModel()
        if dataDog?.breeds?[0].name != nil{
            titleLabel.text =  dataDog?.breeds?[0].name
        }
        if dataDog?.url != nil{
            dogVIewModel?.downloadImage(0, CGSize(width: self.dogImageView.frame.width , height: self.dogImageView.frame.height), url: (dataDog?.url)!, completion: {
                (image, row) in
                self.dogImageView.image = image
            })
        }
    }

}

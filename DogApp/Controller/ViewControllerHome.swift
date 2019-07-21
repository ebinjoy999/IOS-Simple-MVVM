//
//  ViewController.swift
//  CheckinList1
//
//  Created by Ebin Joy on 21/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import UIKit

class ViewControllerHome: UIViewController {

    var dogVIewModel: DogVIewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("asdqsad")
        dogVIewModel = DogVIewModel()
        dogVIewModel?.getDogList(type: .dogLIst)
    }

}


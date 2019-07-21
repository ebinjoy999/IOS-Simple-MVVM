//
//  ViewController.swift
//  CheckinList1
//
//  Created by Ebin Joy on 21/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import UIKit

class ViewControllerHome: UIViewController, DogViewModelDelegate {
    
    @IBOutlet var tableViewDog: UITableView!
    var dogVIewModel: DogVIewModel?
    var myActivityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dogVIewModel = DogVIewModel()
        dogVIewModel?.resetItem()
        dogVIewModel?.getDogList(type: .dogLIst)
        
        dogVIewModel?.delegate = self
        tableViewDog.delegate = self
        tableViewDog.dataSource = self
        addFooterLoadingView()
    }
    
    
    func addFooterLoadingView(){
        let tableFooterView  = UIView(frame: CGRect(x: 0, y: 0, width: tableViewDog.frame.size.width, height: 75))
        tableFooterView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
         myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        myActivityIndicator!.center = CGPoint(x: tableFooterView.frame.size.width  / 2,
                                             y: tableFooterView.frame.size.height / 2)
        myActivityIndicator!.hidesWhenStopped = false
        tableFooterView.addSubview(myActivityIndicator!)
        tableViewDog.tableFooterView = tableFooterView
    }
    
    func reloadDogList(type: ListType, page: Int) {
        tableViewDog?.reloadData()
    }
    
    func showloading(_ isPagination: Bool) {
        myActivityIndicator!.startAnimating()
    }
    
    func stopLoading(_ isPagination: Bool) {
        myActivityIndicator!.stopAnimating()
    }
    

}


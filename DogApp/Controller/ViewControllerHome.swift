//
//  ViewController.swift
//  CheckinList1
//
//  Created by Ebin Joy on 21/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import UIKit

class ViewControllerHome: UIViewController {
    
    @IBOutlet var tableViewDog: UITableView!
    var myActivityIndicator: UIActivityIndicatorView?
    let dataSource = DogDataSource()
    
    lazy var dogVIewModel: DogVIewModel = {
        let viewModel = DogVIewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDog.delegate = self
        tableViewDog.dataSource = dataSource
        dataSource.dogVIewModel = dogVIewModel
        dogVIewModel.getDogList(type: .dogLIst)
        addFooterLoadingView()
        
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            self!.reloadDogList(type: .dogLIst , page: 0)
        }
        
        self.dogVIewModel.onErrorHandling = { [weak self] error in
            let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
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
         DispatchQueue.main.async {
            self.tableViewDog?.reloadData()
        }
    }
    
    func showloading(_ isPagination: Bool) {
        DispatchQueue.main.async {
            self.myActivityIndicator!.startAnimating()
        }
    }
    
    func stopLoading(_ isPagination: Bool) {
        DispatchQueue.main.async {
            self.myActivityIndicator!.stopAnimating()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = tableViewDog.indexPathForSelectedRow?.row
        var detailViewController = segue.destination as! DetailViewController
        detailViewController.dataDog =  dogVIewModel.dataSource?.data.value[index ??  0]
    }

}


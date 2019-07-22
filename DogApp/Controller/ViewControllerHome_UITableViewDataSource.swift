//
//  ViewController_UITableViewDataSource.swift
//  CheckinList1
//
//  Created by Ebin Joy on 21/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import Foundation
import UIKit

extension ViewControllerHome: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dogVIewModel?.dogs.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:DogCell = self.tableViewDog.dequeueReusableCell(withIdentifier: "DogCell") as! DogCell
        cell.loadData(dogVIewModel!,dogVIewModel!.dogs[indexPath.row], indexPath.row)
        return cell
    }
    
    
}

//
//  ViewController_UITableViewDelegate.swift
//  CheckinList1
//
//  Created by Ebin Joy on 21/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import Foundation
import UIKit

extension ViewControllerHome: UITableViewDelegate{
    
    private func tableView(_: UITableView, willDisplay: UITableViewCell, forRowAt: IndexPath){
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
    }
    
    func tableView(_ tableView: UITableView,
                   didEndDisplaying cell: UITableViewCell,
                   forRowAt indexPath: IndexPath){
        dogVIewModel.removedDogAt(row: indexPath.row)
    }
}

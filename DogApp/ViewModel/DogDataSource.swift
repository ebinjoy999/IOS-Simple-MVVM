//
//  DogDataSource.swift
//  DogApp
//
//  Created by Ebin Joy on 28/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class DogDataSource : GenericDataSource<Dog>, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:DogCell = tableView.dequeueReusableCell(withIdentifier: "DogCell") as! DogCell
        cell.dog = data.value[indexPath.row]
       // cell.loadImageData(dogVIewModel!, indexPath.row)
        return cell
    }
    
    
}

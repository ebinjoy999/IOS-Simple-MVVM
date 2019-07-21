//
//  ViewControllerHome_UIScrollViewDelegate.swift
//  DogApp
//
//  Created by Ebin Joy on 22/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import Foundation
import UIKit

extension ViewControllerHome : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        let buffer: CGFloat = CGFloat(AppConstant.BUFFER_ROWS_PAGINATION * 120) //self.cellHeight
        let scrollPosition = scrollView.contentOffset.y
        if scrollPosition > bottom - buffer {
            // Add more datas to the bottom
            dogVIewModel?.getDogList(type: .dogLIst)
        }
    }
    
}

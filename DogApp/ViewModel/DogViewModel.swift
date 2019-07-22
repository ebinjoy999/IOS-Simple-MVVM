//
//  DogViewModel.swift
//  CheckinList1
//
//  Created by Ebin Joy on 21/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import Foundation
import UIKit

protocol DogViewModelDelegate {
    func reloadDogList(type: ListType, page: Int)
    func showloading(_ isPagination :Bool)
    func stopLoading(_ isPagination :Bool)
}

class DogVIewModel{
    
   var dogs = [Dog]()
   var dogService: DogService?
   var CURRENT_PAGE = 0
   var isLoading = false
   var delegate: DogViewModelDelegate?
   
    init(){
        dogService = DogService()
    }
    
    func resetItem(){
        CURRENT_PAGE = 0
        isLoading = false
        dogs = [Dog]()
        self.delegate?.reloadDogList(type: .dogLIst, page: self.CURRENT_PAGE)
    }
    
    func downloadImage( _ row :Int, _ cgSize: CGSize,
                       url :String, completion: @escaping (_ image: UIImage, _  row :Int) -> ())  {
        dogService!.downloadImage(row, cgSize, url: url, completion: completion)
    }
    func removedDogAt(row: Int){
        //task when disappear row
        dogService!.cancelDownloadImageTask(row: row)
        
    }
    
    func getDogList(type :ListType){
        guard let dogS = dogService else { return }
        if(!isLoading  && !dogS.isLoadedAllItem){
            CURRENT_PAGE += 1
            isLoading = true
            self.delegate?.showloading((CURRENT_PAGE == 1 ) ? true : false)
            dogS.getDogList(listType: type, page: CURRENT_PAGE, completion: {
                (response) in
                switch response{
                case .success(var result):
                    if(result.dogs.count<AppConstant.PAGE_LIMIT){
                        dogS.isLoadedAllItem = true
                    }
                    self.dogs.append(contentsOf: result.dogs)
                    DispatchQueue.main.async {
                      self.delegate?.reloadDogList(type: result.type!, page: self.CURRENT_PAGE)
                    }
                    break
                case .failure:
                    break
                }
                self.delegate?.stopLoading((self.CURRENT_PAGE == 1 ) ? true : false)
                self.isLoading = false
            })
        }
    }
}

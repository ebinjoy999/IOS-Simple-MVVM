//
//  DogViewModel.swift
//  CheckinList1
//
//  Created by Ebin Joy on 21/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import Foundation
import UIKit

//protocol DogViewModelDelegate {
//    func reloadDogList(type: ListType, page: Int)
//    func showloading(_ isPagination :Bool)
//    func stopLoading(_ isPagination :Bool)
//}

class DogVIewModel{
    
    weak var dataSource : GenericDataSource<Dog>?
    var onErrorHandling : ((ErrorResult?) -> Void)?
    var service: DogService?
    var isLoading = false
   
    init(service: DogService = DogService(),
         dataSource : GenericDataSource<Dog>?){
        self.dataSource = dataSource
        self.service = service
    }
    
    func resetItem(){
        isLoading = false
//        dogs = [Dog]()
//        self.delegate?.reloadDogList(type: .dogLIst, page: self.CURRENT_PAGE)
    }
    
    func downloadImage( _ row :Int, _ cgSize: CGSize,
                       url :String, completion: @escaping (_ image: UIImage, _  row :Int) -> ())  {
        service!.downloadImage(row, cgSize, url: url, completion: completion)
    }
    
    func removedDogAt(row: Int){
        //task when disappear row
        service!.cancelDownloadImageTask(row: row)
        
    }
    
    func getDogList(type :ListType){
        guard let dogService = service else { return }
        if(!isLoading && !dogService.isLoadedAllItem){
            isLoading = true
           // self.delegate?.showloading((CURRENT_PAGE == 1 ) ? true : false)
            var nextPagetToLoad = 1
            if let totCount = dataSource?.data.value.count {
                nextPagetToLoad = totCount / AppConstant.PAGE_LIMIT
                nextPagetToLoad += 1
            }
            dogService.getDogList(listType: type, page: nextPagetToLoad, completion: {
                (response) in
                switch response{
                case .success(let result):
                    if(result.dogs.count<AppConstant.PAGE_LIMIT){
                        dogService.isLoadedAllItem = true
                    }
                    self.dataSource?.data.value.append(contentsOf: result.dogs)
                    DispatchQueue.main.async {
                    //  self.delegate?.reloadDogList(type: result.type!, page: self.CURRENT_PAGE)
                    }
                    break
                case .failure:
                    break
                }
//                self.delegate?.stopLoading((self.CURRENT_PAGE == 1 ) ? true : false)
                self.isLoading = false
            })
        }
    }
}

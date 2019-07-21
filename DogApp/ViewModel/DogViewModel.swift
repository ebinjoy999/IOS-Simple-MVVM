//
//  DogViewModel.swift
//  CheckinList1
//
//  Created by Ebin Joy on 21/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import Foundation

protocol DogViewModelDelegate {
    func reloadDogList(type: ListType, page: Int)
    func showloading(_ isPagination :Bool)
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
    
    func getDogList(type :ListType){
        guard let dogS = dogService else { return }
        if(!isLoading  && !dogS.isLoadedAllItem){
            self.delegate?.showloading((CURRENT_PAGE == 0 ) ? true : false)
            isLoading = true
            CURRENT_PAGE += 1
            dogS.getDogList(listType: type, page: CURRENT_PAGE, completion: {
                (response) in
                switch response{
                case .success(var result):
                    self.dogs.append(contentsOf: result.dogs)
                    self.delegate?.reloadDogList(type: result.type!, page: self.CURRENT_PAGE)
                    self.isLoading = false
                    break
                case .failure:
                    self.isLoading = false
                    break
                }
            })
        }
    }
}

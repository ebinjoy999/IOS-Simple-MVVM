//
//  DogService.swift
//  DogApp
//
//  Created by Ebin Joy on 21/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import Foundation

enum  DogDataResponse {
    case success(result: DogList)
    case failure
}

class DogService: BaseService {
 var isLoadedAllItem  = false
    
    func getDogList(listType: ListType, page:Int, completion: @escaping (DogDataResponse) -> Void ) {
        let endPoint = setEndPoint(type: listType)
        callEndPoint(endPoint: endPoint.rawValue, method: "GET") { [weak self]
            (response) in
            guard let strongSelf = self else {
                return
            }
            switch response{
            case .success(let result):
                strongSelf.parseResult(result: result, completion: completion)
                break
            case .failure(let message, let statCode):
                 completion(.failure)
                break
            case .notConnectedToInternet:
                 completion(.failure)
                break
            }
            
        }
    }
    
    private func parseResult(result: Data, completion: @escaping (DogDataResponse) -> Void) {
        var data:DogList?
        do{
            data = try DogList(json: result)
        }catch{
            completion(.failure)
            return
        }
        guard  (data != nil) else {
            completion(.failure)
            return
        }
        completion(.success(result: data!))
    }
    
    private func setEndPoint(type: ListType) -> DogEndPint {
        var endPoint: DogEndPint
        switch type {
        case .dogLIst:
            endPoint = .listBreeds
        }
        return endPoint
    }
}

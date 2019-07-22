//
//  DogService.swift
//  DogApp
//
//  Created by Ebin Joy on 21/07/19.
//  Copyright © 2019 Ebin Joy. All rights reserved.
//

import Foundation
import UIKit

enum  DogDataResponse {
    case success(result: DogList)
    case failure
}

class DogService: BaseService {
 var isLoadedAllItem  = false
    
    func downloadImage( _ row :Int, _ cgSize: CGSize, url :String, completion: @escaping (_ image: UIImage,  _ row :Int) -> ()){
        callEndPoint(download_mode: true, page: 0, endPoint: url, method: "GET") { [weak self]
            (response) in
            guard self != nil else {
                return
            }
            switch response{
            case .success(let result):
                 let image = UIImage(data: result)
                 completion(self!.resizeImage(image: image!, targetSize: cgSize), row)
//                 imageView = UIImageView(image: image)
                break
            case .failure(let message, let statCode): break
            case .notConnectedToInternet: break
            }
            
        }
    }
    
    func getDogList(listType: ListType, page:Int, completion: @escaping (DogDataResponse) -> Void ) {
        let endPoint = setEndPoint(type: listType)
        callEndPoint(page: page, endPoint: endPoint.rawValue, method: "GET") { [weak self]
            (response) in
            guard let strongSelf = self else {
                return
            }
            switch response{
            case .success(let result):
                strongSelf.parseResult(listType, result: result, completion: completion)
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
    
    private func parseResult(_ listType: ListType,result: Data, completion: @escaping (DogDataResponse) -> Void) {
        var data:DogList?
        do{
            data = try DogList(json: result)
            data?.type = listType
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
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
let a =        Int(UIScreen.main.scale)
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale) //3d paarameter to map retina display
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
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

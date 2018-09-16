//
//  RequestViewModel.swift
//  Mind
//
//  Created by Adel on 8/13/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation
import Alamofire


class StoreRequestViewModel{
    
    weak var delegate: RequestViewModelDelegate?
    static var errorMsg:String?
    static var arrOfStores:[String] = []
    
    class func getStores (completion:@escaping(_ success:Bool , _ error:String?,_ arrOfStores:[String])-> Void) {
        
        Alamofire.request(Urls.getSotreUrl, method: .get, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                if let stores = response.result.value as? [[String:Any]] {
                    for store in stores {
                        if let storeName = store["Store_title"] as? String {
                            arrOfStores.append(storeName)
                        }
                    }
                    print("strors: \(arrOfStores)")
                    completion(true,nil,arrOfStores)
                    errorMsg = "can't parse json"
                    return
                }
                
            case .failure (let error) :
                errorMsg = String(describing:error)
                print(errorMsg)
                completion(false,errorMsg,arrOfStores)
            }
        }
    }
    // End of the class
}

//////// the extenion
//extension EmpRequestViewModel{
//    func reportSuccessfullLogin(banks:[String])  {
//        DispatchQueue.main.async {
//            self.delegate?.didSuccefull(banks: banks)
//        }
//    }
//
//    func reportfailedLogin(error: NetworkError)  {
//        DispatchQueue.main.async {
//            self.delegate?.didFailure(error:error , errorMessage: "error ocured")
//        }
//    }
//}





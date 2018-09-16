//
//  StoreeSearchRequest.swift
//  Mind
//
//  Created by Adel on 8/29/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation
import Alamofire

class StoreeSearchRequest{
    
    weak var delegate: RequestViewModelDelegate?
    static var errorMsg:String?
    static var arrOfStoreModels:[StoreResultModel] = []
    
    ////////
    class func getStoreDetails (myParameters:Parameters,completion:@escaping(_ success:Bool , _ error:String?,_ arrayOfEmployee:[StoreResultModel])-> Void) {
        
        Alamofire.request(Urls.getStoresSearchUrl, method: .post, parameters: myParameters, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                if let storeModels = response.result.value as? [[String:Any]] {
                    arrOfStoreModels.removeAll()
                    //print("data: \(storeModels)")
                    for storeModel in storeModels {
//
                        arrOfStoreModels.append(StoreResultModel(typeName: (storeModel["Item_title"] as? String)!, type: (storeModel["category"] as? String)!, lowestQntity: (storeModel["min_qty"] as? Double)!, availble: (storeModel["qty"] as? Double)!, buysTotal: (storeModel["total_cost"] as? Double)!, salesTotal: (storeModel["total_sale"] as? Double)!, expirationDate: (storeModel["expired_date"] as? NSNull)!, storeName: (storeModel["Store_title"] as? String)!))
                        //arrOfStoreModels[0].typeName = storeModel["Item_title"] as! String
                    }
                    print("array of stores Result: \(arrOfStoreModels)")
                    completion(true,nil,arrOfStoreModels)
                    errorMsg = "can't parse json"
                    return
                }
                
            case .failure (let error) :
                errorMsg = String(describing:error)
                print( errorMsg )
                completion(false,errorMsg,arrOfStoreModels)
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


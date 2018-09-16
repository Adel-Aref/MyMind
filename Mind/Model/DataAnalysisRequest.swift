//
//  DataAnalysisRequest.swift
//  Mind
//
//  Created by Adel on 9/2/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation
import Alamofire

class DataAnalysisRequest{
    
    weak var delegate: RequestViewModelDelegate?
    static var errorMsg:String?
    static var arrOfDataAnalysisModels:[DataAnalysisModel] = []
    
    ////////
    class func getStoreDetails (myParameters:Parameters,completion:@escaping(_ success:Bool , _ error:String?,_ arrayOfEmployee:[DataAnalysisModel])-> Void) {
        
        Alamofire.request(Urls.getDataAnalysisUrl, method: .post, parameters: myParameters, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                if let dataAnalysisModels = response.result.value as? [[String:Any]] {
                    arrOfDataAnalysisModels.removeAll()
                    print("before appending:\(dataAnalysisModels)")
                    for dataAnalysisModel in dataAnalysisModels {

                        arrOfDataAnalysisModels.append(DataAnalysisModel(Item_title: (dataAnalysisModel["Item_title"] as? String)!, category: (dataAnalysisModel["category"] as? String)!, barcode1: (dataAnalysisModel["barcode1"] as? String)!, barcode2: (dataAnalysisModel["barcode2"] as? String)!, qty: (dataAnalysisModel["qty"] as? Double)!))
                    }
                    completion(true,nil,arrOfDataAnalysisModels)
                    errorMsg = "can't parse json"
                    return
                }
                
            case .failure (let error) :
                errorMsg = String(describing:error)
                print( errorMsg )
                completion(false,errorMsg,arrOfDataAnalysisModels)
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


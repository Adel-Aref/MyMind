//
//  StoreeSearchRequest.swift
//  Mind
//
//  Created by Adel on 8/30/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation
import Alamofire

class ProfitRequest{
    
    weak var delegate: RequestViewModelDelegate?
    static var errorMsg:String?
    static var ProfitModelData:[String:Double] = [:]
    
    ////////
    class func getProfitDetails (myParameters:Parameters,completion:@escaping(_ success:Bool , _ error:String?,_ ProfitObject:[String:Double])-> Void) {
        
        Alamofire.request(Urls.getProfitUrl, method: .post, parameters: myParameters, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                if let ProfitModel = response.result.value as? [String:Double] {
                    ProfitModelData.removeAll()
                    ProfitModelData = ProfitModel
                    print("asd1 : \(ProfitModel)")
                    print("asd2 : \(ProfitModelData)")
                    //for Model in storeModels {
                    
                    //}
                    completion(true,nil,ProfitModelData)
                    errorMsg = "can't parse json"
                    return
                }
                
            case .failure (let error) :
                errorMsg = String(describing:error)
                print( errorMsg )
                completion(false,errorMsg,ProfitModelData)
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


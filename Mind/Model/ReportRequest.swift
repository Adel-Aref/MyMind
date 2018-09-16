//
//  ReportRequest.swift
//  Mind
//
//  Created by Adel on 9/3/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation
import Alamofire

class ReportRequest{
    
    weak var delegate: RequestViewModelDelegate?
    static var errorMsg:String?
    static var arrOfReportsModels:[ReportModel] = []
    
    ////////
    class func getReportsDetails (myParameters:Parameters,completion:@escaping(_ success:Bool , _ error:String?,_ arrayOfEmployee:[ReportModel])-> Void) {
        
         Alamofire.request(Urls.getReportsDetailsUrl, method: .post, parameters: myParameters, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                if let reports = response.result.value as? [[String:Any]] {
                    arrOfReportsModels.removeAll()
                    print("before appending:\(reports)")
                    for report in reports {
                        
                        arrOfReportsModels.append(ReportModel(invoices_date: (report["invoices_date"] as? String)!, Item_title: (report["Item_title"] as? String)!, unit: (report["unit"] as? String)!, qty: (report["qty"] as? Double)!, price: (report["price"] as? Double)!, final:  (report["final"] as? Double)!, earn:  (report["earn"] as? Double)!))
                    }
                    completion(true,nil,arrOfReportsModels)
                    errorMsg = "can't parse json"
                    return
                }
                
            case .failure (let error) :
                errorMsg = String(describing:error)
                print( errorMsg )
                completion(false,errorMsg,arrOfReportsModels)
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


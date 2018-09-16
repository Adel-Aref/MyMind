//
//  RequestViewModel.swift
//  Mind
//
//  Created by Adel on 8/13/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation
import Alamofire

class EmpRequestViewModel{
    
    weak var delegate: RequestViewModelDelegate?
    static var errorMsg:String?
    static var arrOfEmps:[String] = []
    
    class func getEmps (completion:@escaping(_ success:Bool , _ error:String?,_ arrayOfEmployee:[String])-> Void) {
        
        Alamofire.request(Urls.getEmpUrl, method: .get, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                if let emps = response.result.value as? [[String:Any]] {
                    arrOfEmps.removeAll()
                    for emp in emps {
                        if let empName = emp["E_name"] as? String {
                            arrOfEmps.append(empName)
                        }
                    }
                    print("emps: \(arrOfEmps)")
                    completion(true,nil,arrOfEmps)
                    errorMsg = "can't parse json"
                    return
                }
            
            case .failure (let error) :
                errorMsg = String(describing:error)
                print( errorMsg )
                completion(false,errorMsg,arrOfEmps)
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



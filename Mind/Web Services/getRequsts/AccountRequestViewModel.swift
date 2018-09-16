//
//  RequestViewModel.swift
//  Mind
//
//  Created by Adel on 8/13/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation
import Alamofire


class AccountRequestViewModel{
    
    weak var delegate: RequestViewModelDelegate?
    static var errorMsg:String?
    static var arrOfAccounts:[String] = []
    
    class func getAccounts (completion:@escaping(_ success:Bool , _ error:String?,_ arrayOfAccounts:[String])-> Void) {
        
        Alamofire.request(Urls.getAccountUrl, method: .get, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                if let accounts = response.result.value as? [[String:Any]] {
                    for account in accounts {
                        if let accName = account["E_name"] as? String {
                            arrOfAccounts.append(accName)
                        }
                    }
                    print("emps: \(arrOfAccounts)")
                    completion(true,nil,arrOfAccounts)
                    errorMsg = "can't parse json"
                    return
                }
                
            case .failure (let error) :
                errorMsg = String(describing:error)
                print( errorMsg )
                completion(false,errorMsg,arrOfAccounts)
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




//
//  BankRequest.swift
//  Mind
//
//  Created by Mariam on 8/26/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation


import Alamofire


class BankRequest{
    
    weak var delegate: RequestViewModelDelegate?
    static var errorMsg:String?
    static var arrOfBanks:[String] = []
    
    class func getBanks (completion:@escaping(_ success:Bool , _ error:String?,_ arrayOfBanks:[String])-> Void) {
        
        Alamofire.request(Urls.getBankUrl, method: .get, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                if let banks = response.result.value as? [[String:Any]] {
                    for bank in banks {
                        if let bankName = bank["Bank_title"] as? String {
                            arrOfBanks.append(bankName)
                            print(bankName)
                        }
                    }
                    print("banks: \(arrOfBanks)")
                    completion(true,nil,arrOfBanks)
                    errorMsg = "can't parse json"
                    return
                }
                
            case .failure (let error) :
                errorMsg = String(describing:error)
                print( errorMsg )
                completion(false,errorMsg,arrOfBanks)
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




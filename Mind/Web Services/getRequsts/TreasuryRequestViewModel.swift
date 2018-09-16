//
//  TreasuryRequestViewModel.swift
//  Mind
//
//  Created by Adel on 9/3/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation
import Alamofire

class TreasuryRequest{
    
    weak var delegate: RequestViewModelDelegate?
    static var errorMsg:String?
    static var arrOfTreasuries:[String] = []
    
    class func getTreaureies (completion:@escaping(_ success:Bool , _ error:String?,_ arrayOfBanks:[String])-> Void) {
        
        Alamofire.request(Urls.getTreasuryUrl, method: .get, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                if let Treausries = response.result.value as? [[String:Any]] {
                    for Treausry in Treausries {
                        if let TreausryName = Treausry["Treasury_title"] as? String {
                            arrOfTreasuries.append(TreausryName)
                            print(TreausryName)
                        }
                    }
                    print("banks: \(arrOfTreasuries)")
                    completion(true,nil,arrOfTreasuries)
                    errorMsg = "can't parse json"
                    return
                }
                
            case .failure (let error) :
                errorMsg = String(describing:error)
                print( errorMsg )
                completion(false,errorMsg,arrOfTreasuries)
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




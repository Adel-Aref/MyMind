//
//  RequestViewModel.swift
//  Mind
//
//  Created by Adel on 8/13/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestViewModelDelegate: class {
    func didSuccefull(banks:[String])
    func didFailure(error: NetworkError, errorMessage: String)
}

class RequestViewModel{
    

    weak var delegate: RequestViewModelDelegate?
    static var errorMsg:String?
    static var arrOfBanks:[String] = []
    
    class func getBanks()-> [String]{
        
        Alamofire.request(Urls.getBankUrl, method: .get, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result{
            case .success:
                if let banks = response.result.value as? [[String:Any]] {
                    for bank in banks {
                        if let bankTitle = bank["Bank_title"] as? String {
                            arrOfBanks.append(bankTitle)
                        }
                    }
//                    print("Banks \(arrOfBanks)")
                //self.reportSuccessfullLogin(banks: banks)
                    
                    errorMsg = "can't parse json"
                    
                    return
                }
            case .failure (let error) :
               // self.reportfailedLogin()
              
                print("Error in json is : \(response.result.error)")
            }
        }
        
        return arrOfBanks
    }
    
    // End of the class
}

//////// the extenion
extension RequestViewModel{
    func reportSuccessfullLogin(banks:[String])  {
        DispatchQueue.main.async {
            self.delegate?.didSuccefull(banks: banks)
        }
    }
    
    func reportfailedLogin(error: NetworkError)  {
        DispatchQueue.main.async {
            self.delegate?.didFailure(error:error , errorMessage: "error ocured")
        }
    }
}


//
//  urlRequest.swift
//  Mind
//
//  Created by Mariam on 8/26/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation

import Alamofire

protocol urlRequestDelegate: class {
    func didSuccefull(user:[String:Any])
    func didFailure(error: Error, errorMessage: String)
}

class urlRequest{
    
    
    weak var delegate: urlRequestDelegate?
    static var errorMsg:String?
    //static var arrOfBanks:[String] = []
    let pass = UserDefaults.standard.string(forKey: "password")
    
    func getUser(userURL : String , password : String){
        
        let url = "\(String(userURL))/api/Login/Get_User?pass=\(pass)"
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default).responseJSON { (response) in
            
            switch response.result{
            case .success:
                
                let user : [String:Any] = response.result.value as! [String : Any]
                print(user)
                self.reportSuccessfullLogin(user: user)
                
            case .failure (let error) :
                // self.reportfailedLogin()
                
                print("Error in json is : \(response.result.error)")
                self.reportfailedLogin(error: error)
            }
        }
        
        
        
        
        
        
        // End of the class
    }
}

//////// the extenion
extension urlRequest{
    func reportSuccessfullLogin(user:[String:Any])  {
        DispatchQueue.main.async {
            self.delegate?.didSuccefull(user: user)
        }
    }
    
    func reportfailedLogin(error: Error)  {
        DispatchQueue.main.async {
            self.delegate?.didFailure(error:error , errorMessage: "error ocured")
        }
    }
}


//
//  ReportDailyRequest.swift
//  Mind
//
//  Created by Mariam on 8/26/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation


import Alamofire

protocol ReportDailyRequestDelegate: class {
    func didSuccefull(report:[String:Any])
    func didFailure(error: Error, errorMessage: String)
}

class ReportDailyRequest{
    
    
    weak var delegate: ReportDailyRequestDelegate?
    static var errorMsg:String?
    //static var arrOfBanks:[String] = []
    
    func getReportDaily(with  Account_title : String,
                        Store_title: String, Bank_title: String, Treasury_title: String,
                        From_date: String, To_date: String,E_name: String){
        
        let url = "http://mindit-001-site2.atempurl.com/api/Report_Daily/Get_Report_Daily"
        
        let parameters = ["Account_title": Account_title,
                          "Store_title": Store_title,
                          "Bank_title": Bank_title,
                          "Treasury_title": Treasury_title,
                          "From_date": From_date,
                          "To_date": To_date,
                          "E_name": E_name,
                          "Return_Qty": true,
                          "Limit": 8,
                          "qty": 9.1] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding:URLEncoding.default ).responseJSON{
            (response) in
            
            switch response.result{
            case .success:
                
                let report : [String:Any] = response.result.value as! [String : Any]
                print(report)
                self.reportSuccessfullLogin(report : report)
                
            case .failure (let error) :
                // self.reportfailedLogin()
                
                print("Error in json is : \(response.result.error)")
                self.reportfailedLogin(error: error)
            }
        }
        
        //        Alamofire.request(url, method: .get, encoding: URLEncoding.default).responseJSON { (response) in
        //
        //            switch response.result{
        //            case .success:
        //
        //                let user : [String:Any] = response.result.value as! [String : Any]
        //                print(user)
        //                self.reportSuccessfullLogin(user: user)
        //
        //            case .failure (let error) :
        //                // self.reportfailedLogin()
        //
        //                print("Error in json is : \(response.result.error)")
        //                self.reportfailedLogin(error: error)
        //            }
        //        }
        
        
        
        
        
        
        // End of the class
    }
}

//////// the extenion
extension ReportDailyRequest{
    func reportSuccessfullLogin(report:[String:Any])  {
        DispatchQueue.main.async {
            self.delegate?.didSuccefull(report: report)
        }
    }
    
    func reportfailedLogin(error: Error)  {
        DispatchQueue.main.async {
            self.delegate?.didFailure(error:error , errorMessage: "error ocured")
        }
    }
}


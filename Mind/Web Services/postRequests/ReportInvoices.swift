//
//  ReportInvoices.swift
//  Mind
//
//  Created by Mariam on 9/2/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation
import Alamofire

protocol ReportInvoicesDelegate: class {
    func didSuccefull(report:[String:Any])
    func didFailure(error: Error, errorMessage: String)
}

class ReportInvoices{
    
    
    weak var delegate: ReportInvoicesDelegate?
    static var errorMsg:String?
    //static var arrOfBanks:[String] = []
    
    func getReportInvoices(with  kind:String , account:String ,  bank:String , treasury:String , fromDate:String , toDate:String ){
        
        let url = "http://mindit-001-site2.atempurl.com/api/Report_Invoices/Get_Report_Invoices"
        
        let parameters = ["kind": kind,
                          "Account_title": account,
                          "Bank_title": bank,
                          "Treasury_title": treasury,
                          "From_date": fromDate,
                          "To_date": toDate] as [String : Any]
        
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
extension ReportInvoices{
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


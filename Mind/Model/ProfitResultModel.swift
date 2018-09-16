//
//  ProfitResultModel.swift
//  Mind
//
//  Created by Adel on 8/30/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation
class ProfitResultModel{
    let Sale_earn: Double
    let Bad: Double
    let Expenes: Double
    let Total_earn: Double
    let Sale_tax: Double
    let Buy_tax :Double
    let Total_tax:Double
    
    // Init initializer
    init(Sale_earn: Double, Bad: Double, Expenes: Double, Total_earn: Double,Sale_tax: Double,Buy_tax :Double,Total_tax:Double) {
        self.Sale_earn = Sale_earn
        self.Bad = Bad
        self.Expenes = Expenes
        self.Total_earn = Total_earn
        self.Sale_tax = Sale_tax
        self.Buy_tax = Buy_tax
        self.Total_tax = Total_tax
        
    }
    
    //    convenience init(with json: [String: Any]) {
    ////        let priceId = json["contentPriceList"] as! String
    ////        let itemId = json["contentId"] as! String
    ////        let name = json["itemName"] as? String ?? ""
    ////        let price = json["itemPrice"] as! String
    ////        self.init(priceId: priceId, itemId: itemId, name: name, price: price)
    //    }
}


//  ReportModel.swift
//  Mind
//
//  Created by Adel on 9/3/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation
class ReportModel{
    let invoices_date: String
    let Item_title  : String
    let unit: String
    let qty: Double
    let price: Double
    let final: Double
    let earn: Double
    
    init(invoices_date: String, Item_title: String, unit: String, qty: Double,price: Double, final: Double,earn: Double) {
        self.invoices_date = invoices_date
        self.Item_title = Item_title
        self.unit = unit
        self.qty = qty
        self.price = price
        self.final = final
        self.earn = earn
        
    }
    
    //    convenience init(with json: [String: Any]) {
    ////        let priceId = json["contentPriceList"] as! String
    ////        let itemId = json["contentId"] as! String
    ////        let name = json["itemName"] as? String ?? ""
    ////        let price = json["itemPrice"] as! String
    ////        self.init(priceId: priceId, itemId: itemId, name: name, price: price)
    //    }
}

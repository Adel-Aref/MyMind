//
//  DataAnalysisModel.swift
//  Mind
//
//  Created by Adel on 9/2/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation
class DataAnalysisModel{
    let Item_title: String
    let category: String
    let barcode1: String
    let barcode2: String
    let qty: Double
    
    init(Item_title: String, category: String, barcode1: String, barcode2: String,qty: Double) {
        self.Item_title = Item_title
        self.category = category
        self.barcode1 = barcode1
        self.barcode2 = barcode2
        self.qty = qty
        
    }
    
    //    convenience init(with json: [String: Any]) {
    ////        let priceId = json["contentPriceList"] as! String
    ////        let itemId = json["contentId"] as! String
    ////        let name = json["itemName"] as? String ?? ""
    ////        let price = json["itemPrice"] as! String
    ////        self.init(priceId: priceId, itemId: itemId, name: name, price: price)
    //    }
}

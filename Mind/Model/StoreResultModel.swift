//
//  StoreResultModel.swift
//  Mind
//
//  Created by Adel on 8/29/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation
class StoreResultModel{
    var typeName: String
    var type: String
    var lowestQntity: Double
    var availble: Double
    var buysTotal: Double
    var salesTotal :Double
    var expirationDate:NSNull
    var storeName:String
    
    init(typeName: String, type: String, lowestQntity: Double, availble: Double,buysTotal: Double,salesTotal :Double,expirationDate:NSNull,storeName:String) {
        self.typeName = typeName
        self.type = type
        self.lowestQntity = lowestQntity
        self.availble = availble
        self.buysTotal = buysTotal
        self.salesTotal = salesTotal
        self.expirationDate = expirationDate
        self.storeName = storeName
        
    }
    
    //    convenience init(with json: [String: Any]) {
    ////        let priceId = json["contentPriceList"] as! String
    ////        let itemId = json["contentId"] as! String
    ////        let name = json["itemName"] as? String ?? ""
    ////        let price = json["itemPrice"] as! String
    ////        self.init(priceId: priceId, itemId: itemId, name: name, price: price)
    //    }
}

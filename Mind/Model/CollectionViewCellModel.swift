//
//  CollectionViewCellModel.swift
//  Report
//
//  Created by Mariam on 8/4/18.
//  Copyright © 2018 Mariam. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCellModel: NSObject {
    
    var images : [UIImage] = []
    
    
    // Assemble an array of images to use for sample content for the collectionView
    func buildDataSource(){
        
        let image1 = UIImage(named: "1")
        let image2 = UIImage(named: "2")
        let image3 = UIImage(named: "2")
        let image4 = UIImage(named: "2")
        let image5 = UIImage(named: "2")
        let image6 = UIImage(named: "2")
        let image7 = UIImage(named: "2")
        
        images.append(image1!)
        images.append(image2!)
        images.append(image3!)
        images.append(image4!)
        images.append(image5!)
        images.append(image6!)
        images.append(image7!)
        
    }
}

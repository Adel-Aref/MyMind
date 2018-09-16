//
//  StoreSearch.swift
//  Mind
//
//  Created by Adel on 8/29/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import UIKit

class StoreSearch: UITableViewCell {

    @IBOutlet weak var lblExpirationDate: UILabel!
  
    
    @IBOutlet weak var lblStoreName: UILabel!
    
    @IBOutlet weak var lblAvailable: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblBuysTotal: UILabel!
    @IBOutlet weak var lblSalesTotal: UILabel!
    @IBOutlet weak var lblLowestQntity: UILabel!
    @IBOutlet weak var lblTypeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

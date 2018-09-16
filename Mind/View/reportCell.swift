//
//  reportCell.swift
//  Mind
//
//  Created by Adel on 8/9/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import UIKit

class reportCell: UITableViewCell {

    @IBOutlet weak var lblEmp: UILabel!
    @IBOutlet weak var lblMovingDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblProfit: UILabel!
    @IBOutlet weak var lblAccountName: UILabel!
    @IBOutlet weak var lblFinal: UILabel!
    @IBOutlet weak var lblQuntty: UILabel!
    @IBOutlet weak var lblNameCategory: UILabel!
    @IBOutlet weak var lblUnit: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

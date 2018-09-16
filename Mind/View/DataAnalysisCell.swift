//
//  thirdCell.swift
//  Mind
//
//  Created by Adel on 8/9/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import UIKit

class DataAnalysisCell: UITableViewCell {

    @IBOutlet weak var lbltitleName: UILabel!

    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblBarcode1: UILabel!
    @IBOutlet weak var lblQntty: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var lblBarcode2: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

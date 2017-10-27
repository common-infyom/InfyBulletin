//
//  creditCardTableCell.swift
//  CustomBulletinBoard
//
//  Created by Dhvl Golakiya on 10/10/17.
//  Copyright © 2017 infyom. All rights reserved.
//

import UIKit

class creditCardTableCell: UITableViewCell {

    //@IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var imageDataView: UIImageView!
    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

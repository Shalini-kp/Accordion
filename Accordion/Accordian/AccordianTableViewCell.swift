//
//  AccordianTableViewCell.swift
//  Accordian
//
//  Copyright © 2019 Shalini. All rights reserved.
//

import UIKit

class AccordianTableViewCell: UITableViewCell {

    @IBOutlet weak var accordianTitleText: UILabel!
    @IBOutlet weak var accordianImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  carTableViewCell.swift
//  coredata_cars
//
//  Created by Luis Andres Castillo Hernandez on 11/20/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit

class carTableViewCell: UITableViewCell
{

    @IBOutlet weak var carMakeLabel: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var carYearLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
    
}//eoc

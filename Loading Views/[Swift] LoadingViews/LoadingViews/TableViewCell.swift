//
//  TableViewCell.swift
//  LoadingViews
//
//  Created by Luis Andres Castillo Hernandez on 11/18/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell
{
    
  
    
    @IBOutlet weak var NIBCellLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

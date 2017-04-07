//
//  BaseTableViewCell.swift
//  tableviews
//
//  Created by lu on 4/6/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

extension BaseTableViewCell:ReusableView , NibLoadableView {
    
}

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(data:PersonsData){
        self.textLabel?.text = data.index
    }
}

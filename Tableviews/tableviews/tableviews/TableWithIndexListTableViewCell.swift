//
//  TableWithIndexListTableViewCell.swift
//  tableviews
//
//  Created by lu on 4/7/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

extension TableWithIndexListTableViewCell:ReusableView , NibLoadableView {
    
}

class TableWithIndexListTableViewCell: UITableViewCell {

    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


//MARK: - Config
extension TableWithIndexListTableViewCell {

    func configCell(_ data:String){
        self.textLabel?.text = data
    }
}

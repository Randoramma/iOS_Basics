//
//  NibLoadableView.swift
//  tableviews
//
//  Created by lu on 4/6/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
    
    static var NibName: String {
        return String(describing: self)
    }
}

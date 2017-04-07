//
//  ReusableView.swift
//  tableviews
//
//  Created by lu on 4/6/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


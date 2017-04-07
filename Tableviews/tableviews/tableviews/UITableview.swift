//
//  UITableview.swift
//  tableviews
//
//  Created by lu on 4/6/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

extension UITableView {
    
    //MARK: - Cells
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let Nib:UINib = UINib(nibName: T.NibName, bundle: nil)
        register(Nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    //MARK: - IndexPath
    func createIndexPaths(section:Int, start:Int, end:Int)->[IndexPath]
    {
        var indexPaths:[IndexPath] = []
        for iter in start..<end
        {
            let currPath:IndexPath = IndexPath(row: iter, section: section)
            indexPaths.append(currPath)
        }
        
        return indexPaths
    }//eom
    
    
    //MARK: - Cells
    func numberOfCellsThatFitOnScreen()->Int {
        let calcCells:CGFloat = self.frame.size.height / self.rowHeight
        let cellsFitOnScreen:Int = Int(calcCells)
        
        return cellsFitOnScreen
    }//eom
}

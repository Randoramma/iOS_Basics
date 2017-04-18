//
//  CustomSearchController.swift
//  tableviews
//
//  Created by lu on 4/7/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

protocol CustomSearchControllerDelegate {
    func didStartSearching()
    func didTapOnSearchButton()
    func didTapOnCancelButton()
    func didChangeSearchText(_ searchText: String)
}

class CustomSearchController: UISearchController {
    
    // MARK: - Properties
    var customSearchBar: CustomSearchBar!
    var customDelegate: CustomSearchControllerDelegate!
    
    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Initialization
    init(searchResultsController: UIViewController!,
         searchBarFrame: CGRect,
         searchBarFont: UIFont,
         searchBarPlaceholderTextColor:UIColor = UIColor.lightGray,
         searchBarTintColor: UIColor,
         searchBarBackgroundTintColor: UIColor,
         searchBarBackgroundColor: UIColor,
         seperatorColor: UIColor? = nil,
         hasBookmark:Bool = false,
         hasCancel:Bool = true,
         barStyle:UISearchBarStyle = .prominent,
         isTranslucent: Bool = true) {
        super.init(searchResultsController: searchResultsController)
        
        configureSearchBar(frame:searchBarFrame,
                           font: searchBarFont,
                           placeholderTextColor: searchBarPlaceholderTextColor,
                           tintColor: searchBarTintColor,
                           bgTintColor: searchBarBackgroundTintColor,
                           bgColor: searchBarBackgroundColor,
                           seperatorColor: seperatorColor,
                           hasBookmark:hasBookmark,
                           hasCancel:hasCancel,
                           style: barStyle,
                           isTranslucent: isTranslucent)
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Custom functions
    func configureSearchBar(frame: CGRect,
                            font: UIFont,
                            placeholderTextColor: UIColor,
                            tintColor: UIColor,
                            bgTintColor: UIColor,
                            bgColor: UIColor,
                            seperatorColor: UIColor?,
                            hasBookmark:Bool,
                            hasCancel:Bool,
                            style: UISearchBarStyle,
                            isTranslucent: Bool) {
        
        customSearchBar = CustomSearchBar(frame: frame,
                                          font: font,
                                          placeholderTextColor: placeholderTextColor,
                                          tintColor: tintColor,
                                          backgroundTintColor: bgTintColor,
                                          backgroundColor: bgColor,
                                          clearBackground: false,
                                          seperatorColor: seperatorColor,
                                          style: style,
                                          isTranslucent: isTranslucent)
        
        customSearchBar.showsBookmarkButton = hasBookmark
        customSearchBar.showsCancelButton   = hasCancel
        customSearchBar.delegate            = self
    }
}

// MARK: - UISearchBarDelegate functions
extension CustomSearchController:UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        customDelegate.didStartSearching()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        customSearchBar.resignFirstResponder()
        customDelegate.didTapOnSearchButton()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        customSearchBar.resignFirstResponder()
        customDelegate.didTapOnCancelButton()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        customDelegate.didChangeSearchText(searchText)
    }
}

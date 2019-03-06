//
//  SearchInputView.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//


import UIKit
import RxSwift

class SearchInputView: UIView, Nibable {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var numberLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        searchBar.barTintColor = .lightGray
        searchBar.tintColor = .gray
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.layer.borderWidth = 1
        searchBar.autocapitalizationType = .none
        numberLable.textColor = .gray
    }
}

//
//  Nibable.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//

import UIKit

protocol Nibable: NSObjectProtocol {
    associatedtype Instance
    static func makeFromNib(_ index: Int) -> Instance
    static var nib: UINib { get }
    static var nibName: String { get }
}

extension Nibable {
    static var nibName: String {
        return className
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
    
    static func makeFromNib(_ index: Int = 0) -> Self {
        return nib.instantiate(withOwner: self, options: nil)[index] as! Self
    }
}

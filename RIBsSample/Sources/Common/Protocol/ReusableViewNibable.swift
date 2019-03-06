//
//  ReusableViewNibable.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//

import UIKit

protocol ReusableViewNibable: Nibable {
    static var identifier: String { get }
}

extension ReusableViewNibable {
    static var identifier: String {
        return className
    }
}

extension UITableViewHeaderFooterView: ReusableViewNibable {}

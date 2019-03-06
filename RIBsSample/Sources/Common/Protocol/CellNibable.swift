//
//  CellNibable.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//

import UIKit

protocol CellNibable: Nibable {
    static var identifier: String { get }
}

extension CellNibable {
    static var identifier: String {
        return className
    }
}

extension UITableViewCell: CellNibable {}
extension UICollectionReusableView: CellNibable {}

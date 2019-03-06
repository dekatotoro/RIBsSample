//
//  UINavigationControllerExtension.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

import RIBs
import UIKit

extension UINavigationController: ViewControllable {

    public var uiviewController: UIViewController { return self }

    public convenience init(viewControllable: ViewControllable) {
        self.init(rootViewController: viewControllable.uiviewController)
    }
}




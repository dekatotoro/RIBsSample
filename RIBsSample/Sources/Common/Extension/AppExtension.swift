//
//  AppExtension.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 dekatotoro. All rights reserved.
//

import Foundation

struct AppExtension<Base> {
    let base: Base

    public init(_ base: Base) {
        self.base = base
    }
}

protocol AppExtensionCompatible {
    associatedtype AppExtensionCompatibleType

    var ex: AppExtension<AppExtensionCompatibleType> { get set }

}

extension AppExtensionCompatible {

    var ex: AppExtension<Self> {
        get {
            return AppExtension(self)
        }
        set {
            // this enables using AppExtension to "mutate" base object
        }
    }
}

/// Extend NSObject with `ex` proxy.
extension NSObject: AppExtensionCompatible { }


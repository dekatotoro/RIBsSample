//
//  Storyboardable.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//

import UIKit

protocol Storyboardable: class, NSObjectProtocol {
    associatedtype Instance

    associatedtype Dependency // = Void

    static func makeFromStoryboard(_ dependency: Dependency) -> Instance
    static var storyboard: UIStoryboard { get }
    static var storyboardName: String { get }
    static var identifier: String { get }
}

extension Storyboardable {
    static var storyboardName: String {
        return className
    }

    static var identifier: String {
        return className
    }

    static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: nil)
    }
}

extension Storyboardable where Dependency == Void {
    static func makeFromStoryboard(_ dependency: Dependency) -> Self {
        return unsafeMakeFromStoryboard()
    }

    static func makeFromStoryboard() -> Self {
        return makeFromStoryboard(())
    }
}

extension Storyboardable {

    static func unsafeMakeFromStoryboard() -> Self {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}

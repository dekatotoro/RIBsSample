//
//  UIViewControllerExtension.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension AppExtension where Base: UIViewController {

    func addChild(_ childController: UIViewController) {
        base.addChild(childController)
        base.view.addSubview(childController.view)
        childController.didMove(toParent: base)
    }

    func insertChild(_ childController: UIViewController, belowView: UIView) {
        base.addChild(childController)
        base.view.insertSubview(childController.view, belowSubview: belowView)
        childController.didMove(toParent: base)
    }

    func removeFromParent() {
        base.willMove(toParent: nil)
        base.view.removeFromSuperview()
        base.removeFromParent()
    }

    var viewDidLoad: Observable<Void> {
        return base.rx.methodInvoked(#selector(Base.viewDidLoad)).map(void)
    }

    var viewWillAppear: Observable<Bool> {
        return base.rx.methodInvoked(#selector(Base.viewWillAppear))
            .map { $0.first as? Bool ?? false }
    }

    var viewDidAppear: Observable<Bool> {
        return base.rx.methodInvoked(#selector(Base.viewDidAppear))
            .map { $0.first as? Bool ?? false }
    }

    var viewWillDisappear: Observable<Bool> {
        return base.rx.methodInvoked(#selector(Base.viewWillDisappear))
            .map { $0.first as? Bool ?? false }
    }

    var viewDidDisappear: Observable<Bool> {
        return base.rx.methodInvoked(#selector(Base.viewDidDisappear))
            .map { $0.first as? Bool ?? false }
    }

    var viewWillLayoutSubviews: Observable<Void> {
        return base.rx.methodInvoked(#selector(Base.viewWillLayoutSubviews)).map(void)
    }

    var viewDidLayoutSubviews: Observable<Void> {
        return base.rx.methodInvoked(#selector(Base.viewDidLayoutSubviews)).map(void)
    }

    var willMoveToParentViewController: Observable<UIViewController?> {
        return base.rx.methodInvoked(#selector(Base.willMove)).map { $0.first as? UIViewController }
    }

    var didMoveToParentViewController: Observable<UIViewController?> {
        return base.rx.methodInvoked(#selector(Base.didMove)).map { $0.first as? UIViewController }
    }

    var didReceiveMemoryWarning: Observable<Void> {
        return base.rx.methodInvoked(#selector(Base.didReceiveMemoryWarning)).map(void)
    }

    var viewWillTransition: Observable<(CGSize, UIViewControllerTransitionCoordinator?)> {
        return base.rx.methodInvoked(#selector(Base.viewWillTransition))
            .map { object in
                let size = object.first as? CGSize ?? .zero
                let coordinator = object[1] as? UIViewControllerTransitionCoordinator
                return (size, coordinator)
        }
    }

    var willTransition: Observable<(UITraitCollection?, UIViewControllerTransitionCoordinator?)> {
        return base.rx.methodInvoked(#selector(Base.willTransition))
            .map { object in
                let traitCollection = object.first as? UITraitCollection
                let coordinator = object[1] as? UIViewControllerTransitionCoordinator
                return (traitCollection, coordinator)
        }
    }
}

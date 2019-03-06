//
//  RootViewController.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    var currentViewController: UIViewController?
    weak var listener: RootPresentableListener?

    private var targetViewController: ViewControllable?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
    }

    // MARK: - RootViewControllable

    func replaceCurrentViewController(to: ViewControllable?) {
        guard let targetViewController = to?.uiviewController else { return }

        let from = currentViewController
        currentViewController = targetViewController
        ex.addChild(targetViewController)
        from?.ex.removeFromParent()
    }
}


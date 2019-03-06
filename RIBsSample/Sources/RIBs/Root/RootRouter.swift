//
//  RootRouter.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, SearchListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func replaceCurrentViewController(to: ViewControllable?)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    private let searchBuilder: SearchBuildable

    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         searchBuilder: SearchBuildable) {

        self.searchBuilder = searchBuilder

        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()

        routeToSearch()
    }

    func routeToSearch() {
        let search = searchBuilder.build(withListener: interactor)
        attachChild(search)
        let navigationController = UINavigationController(rootViewController: search.viewControllable.uiviewController)
        viewController.replaceCurrentViewController(to: navigationController)
    }
}

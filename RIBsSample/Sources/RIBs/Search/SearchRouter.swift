//
//  SearchRouter.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

import RIBs

protocol SearchInteractable: Interactable, DetailListener {
    var router: SearchRouting? { get set }
    var listener: SearchListener? { get set }
}

protocol SearchViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewControllable: ViewControllable)
}

final class SearchRouter: ViewableRouter<SearchInteractable, SearchViewControllable>, SearchRouting {

    private let detailBuilder: DetailBuildable
    private weak var currentChild: ViewableRouting?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: SearchInteractable, viewController: SearchViewControllable, detailBuilder: DetailBuilder) {
        self.detailBuilder = detailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    func routeToUser(_ user: GitHubUser) {
        let router = detailBuilder.build(withListener: interactor, gitHubUser: user)
        currentChild = router
        attachChild(router)
        viewController.present(viewControllable: router.viewControllable)
    }

    func detachDetail() {
        if let currentChild = currentChild {
            detachChild(currentChild)
        }
    }
}

extension SearchViewController {
    func present(viewControllable: ViewControllable) {
        navigationController?.pushViewController(viewControllable.uiviewController, animated: true)
    }
}

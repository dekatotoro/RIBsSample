//
//  RootBuilder.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency>, SearchDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.

    fileprivate let rootViewController: RootViewController

    // SearchDependency
    var gitHubAPI: GitHubAPIType {
        return shared { GitHubAPI() }
    }

    init(dependency: RootDependency,
         rootViewController: RootViewController) {
        self.rootViewController = rootViewController

        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> (launchRouter: LaunchRouting, urlHandler: UrlHandler)
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> (launchRouter: LaunchRouting, urlHandler: UrlHandler) {
        let viewController = RootViewController()
        let component = RootComponent(dependency: dependency,
                                      rootViewController: viewController)

        let interactor = RootInteractor(presenter: viewController)
        let searchBuilder = SearchBuilder(dependency: component)

        let router = RootRouter(interactor: interactor,
                                viewController: viewController,
                                searchBuilder: searchBuilder)
        return (router, interactor)
    }
}

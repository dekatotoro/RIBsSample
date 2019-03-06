//
//  DetailBuilder.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

import RIBs

protocol DetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.

    // TODO: Test Implementation to pass dependency to this RIBs
    var gitHubAPI: GitHubAPI { get }
    var mutableSearchStream: MutableSearchStream { get }
}

final class DetailComponent: Component<DetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol DetailBuildable: Buildable {
    func build(withListener listener: DetailListener, gitHubUser: GitHubUser) -> DetailRouting
}

final class DetailBuilder: Builder<DetailDependency>, DetailBuildable {

    override init(dependency: DetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: DetailListener, gitHubUser: GitHubUser) -> DetailRouting {

        // TODO: Test Implementation to pass dependency to this RIBs
        // let component = DetailComponent(dependency: dependency)
        // let mutableSearchStream = dependency.mutableSearchStream
        // dependency.gitHubAPI

        let viewController = DetailViewController.makeFromStoryboard(gitHubUser)
        let interactor = DetailInteractor(presenter: viewController)
        interactor.listener = listener
        return DetailRouter(interactor: interactor, viewController: viewController)
    }
}

//
//  SearchBuilder.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

import RIBs

protocol SearchDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var gitHubAPI: GitHubAPI { get }
}

final class SearchComponent: Component<SearchDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.

    // SearchDependency, DetailDependency
    let gitHubAPI: GitHubAPI

    // DetailDependency
    // TODO: Test Implementation to pass dependency to child RIBs
    var mutableSearchStream: MutableSearchStream {
        return shared { SearchStreamImpl(gitHubAPI: gitHubAPI) }
    }

    override init(dependency: SearchDependency) {
        self.gitHubAPI = dependency.gitHubAPI

        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol SearchBuildable: Buildable {
    func build(withListener listener: SearchListener) -> SearchRouting
}

final class SearchBuilder: Builder<SearchDependency>, SearchBuildable {

    override init(dependency: SearchDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchListener) -> SearchRouting {
        let component = SearchComponent(dependency: dependency)
        let viewController = SearchViewController.makeFromStoryboard()
        let interactor = SearchInteractor(presenter: viewController,
                                          mutableSearchStream: component.mutableSearchStream)
        interactor.listener = listener

        let detailBuilder = DetailBuilder(dependency: component)
        return SearchRouter(interactor: interactor,
                            viewController: viewController,
                            detailBuilder: detailBuilder)
    }
}

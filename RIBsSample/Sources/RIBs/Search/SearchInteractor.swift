//
//  SearchInteractor.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

import RIBs
import RxSwift

protocol SearchRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToUser(_ user: GitHubUser)
    func detachDetail()
}

protocol SearchPresentable: Presentable {
    var listener: SearchPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchInteractor: PresentableInteractor<SearchPresentable>, SearchInteractable {

    weak var router: SearchRouting?
    weak var listener: SearchListener?

    private let mutableSearchStream: MutableSearchStream

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: SearchPresentable, mutableSearchStream: MutableSearchStream) {

        self.mutableSearchStream = mutableSearchStream

        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    // MARK: - DetailListener
    func follow(user: GitHubUser) {
        // TODO: Implement
        print("follow: \(user.name)")
    }
}

extension SearchInteractor: SearchPresentableListener {

    func searchNext() {
        mutableSearchStream.searchNext()
    }

    func search(query: String, page: Int) {
        mutableSearchStream.search(query: query, page: page)
    }

    func routeToUser(_ user: GitHubUser) {
        router?.routeToUser(user)
    }

    func detachDetail() {
        router?.detachDetail()
    }

    var loading: Property<Bool> {
        return mutableSearchStream.loading
    }

    var searchModel: Property<SearchModel<GitHubUser>> {
        return mutableSearchStream.searchModel
    }
}

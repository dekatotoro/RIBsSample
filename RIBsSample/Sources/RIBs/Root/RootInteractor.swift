//
//  RootInteractor.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener, RootActionableItem, UrlHandler {

    weak var router: RootRouting?
    weak var listener: RootListener?

    // TODO: for workflow
    private let searchActionableItemSubject = ReplaySubject<SearchActionableItem>.create(bufferSize: 1)

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    // MARK: - RootActionableItem

    func waitForXXXX() -> Observable<(SearchActionableItem, ())> {
        return searchActionableItemSubject
            .map { ($0, ()) }
    }

    // MARK: - UrlHandler

    func handle(_ url: URL) {
        let launchWorkflow = LaunchWorkflow(url: url)
        launchWorkflow
            .subscribe(self)
            .disposeOnDeactivate(interactor: self)
    }

}

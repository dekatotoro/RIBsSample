//
//  SearchStream.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol SearchStream {
    var loading: Property<Bool> { get }
    var searchModel: Property<SearchModel<GitHubUser>> { get }
}

protocol MutableSearchStream: SearchStream {
    func searchNext()
    func search(query: String, page: Int)
}

class SearchStreamImpl: MutableSearchStream {

    private let _loading = BehaviorRelay<Bool>(value: false)
    let loading: Property<Bool>

    private let _searchModel = BehaviorRelay<SearchModel<GitHubUser>>(value: SearchModel())
    let searchModel: Property<SearchModel<GitHubUser>>

    private let gitHubAPI: GitHubAPI

    private let disposeBag = DisposeBag()

    init(gitHubAPI: GitHubAPI) {
        self.gitHubAPI = gitHubAPI
        self.loading = Property<Bool>(_loading)
        self.searchModel = Property<SearchModel<GitHubUser>>(_searchModel)
    }

    func searchNext() {
        guard searchModel.value.linkHeader?.hasNextPage == true && !loading.value,
            let nextPage = searchModel.value.nextPage else {
                return
        }
        search(query: searchModel.value.searchkey, page: nextPage)
    }

    func search(query: String, page: Int) {

        _loading.accept(true)

        // before the request, the task in the request cancel
        gitHubAPI.cancelSearchUser()

        if query.isEmpty {
            _searchModel.accept(SearchModel<GitHubUser>())
            _loading.accept(false)
            return
        }

        let params = ["q" : query,
                      "page" : page,
                      "per_page" : 30] as [String : Any]

        gitHubAPI.searchUser(params: params)
            .do(onError: { [weak self] error in
                guard let me = self else { return }

                // TODO: error process
                me._loading.accept(false)
            })
            .subscribe(onNext: { [weak self] response in
                guard let me = self else { return }

                let searchModel = SearchModel.make(from: query, gitHubSearchUserResponse: response)

                if page == 0 {
                    me._searchModel.accept(searchModel)
                } else {
                    let new = me._searchModel.value.concat(searchModel: searchModel)
                    me._searchModel.accept(new)
                }
                me._loading.accept(false)
            })
            .disposed(by: disposeBag)
    }

}

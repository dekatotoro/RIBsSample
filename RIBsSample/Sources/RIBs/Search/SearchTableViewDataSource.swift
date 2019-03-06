//
//  SearchTableViewDataSource.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

class SearchTableViewDataSource: NSObject {

    let didTapCell: Observable<GitHubUser>
    private let _didTapCell = PublishRelay<GitHubUser>()

    private let _searchUser = BehaviorRelay(value: SearchModel<GitHubUser>())

    private let disposeBag = DisposeBag()

    init(searchModel: Observable<SearchModel<GitHubUser>>) {
        didTapCell = _didTapCell.asObservable()
        searchModel
            .bind(to: _searchUser)
            .disposed(by: disposeBag)
    }
}

extension SearchTableViewDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _searchUser.value.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(type: SearchCell.self)
        cell.configure(user: _searchUser.value.elements[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = _searchUser.value.elements[indexPath.row]
        _didTapCell.accept(user)
    }
}

extension SearchTableViewDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.5
    }
}

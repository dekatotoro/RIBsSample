//
//  SearchViewController.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//

import RIBs
import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

protocol SearchPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.

    // SearchStreamInput
    func searchNext()
    func search(query: String, page: Int)

    // SearchStreamOutput
    var loading: Property<Bool> { get }
    var searchModel: Property<SearchModel<GitHubUser>> { get }

    // SearchRouting
    func routeToUser(_ user: GitHubUser)
    func detachDetail()
}

class SearchViewController: UIViewController, Storyboardable, SearchPresentable, SearchViewControllable {

    typealias Dependency = Void

    @IBOutlet private weak var searchInputContainer: UIView!
    @IBOutlet private weak var tableView: UITableView!

    private let loadingView = LoadingView()

    weak var listener: SearchPresentableListener?

    private lazy var searchModelRelay: PublishRelay<SearchModel<GitHubUser>> = PublishRelay<SearchModel<GitHubUser>>()
    
    private lazy var tableViewDataSource: SearchTableViewDataSource = .init(searchModel: self.searchModelRelay.asObservable())

    override func viewDidLoad() {
        super.viewDidLoad()

        // - MARK: Configure UI
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = .lightGray
        loadingView.setType(LoadingView.LoadingType.point)
        view.addConstrainEdges(loadingView)

        let searchInputView = SearchInputView.makeFromNib()
        searchInputView.searchBar.becomeFirstResponder()
        searchInputContainer.addConstrainEdges(searchInputView)

        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDataSource
        tableView.tableFooterView = UIView()
        tableView.registerCell(cell: SearchCell.self)

        ex.viewWillAppear
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.isNavigationBarHidden = true
            })
            .disposed(by: rx.disposeBag)

        // dismiss keyboard on scroll
        tableView.rx.didEndDragging
            .subscribe(onNext: { _ in
                if searchInputView.searchBar.isFirstResponder {
                    _ = searchInputView.searchBar.resignFirstResponder()
                }
            })
            .disposed(by: rx.disposeBag)

        // - MARK: SearchStreamInput
        searchInputView.searchBar.rx.text.asDriver()
            .skip(1) // skip init time
            .filterNil()
            .throttle(0.3)
            .distinctUntilChanged()
            .drive(onNext: { [weak self] query in
                self?.listener?.search(query: query, page: 0)
            })
            .disposed(by: rx.disposeBag)

        tableView.ex.scrolledToBottomEnd
            .skip(1)  // skip init time
            .subscribe(onNext:{ [weak self] _ in
                self?.listener?.searchNext()
            })
            .disposed(by: rx.disposeBag)

        // - MARK: SearchStreamOutput
        listener?.loading.asObservable()
            .distinctUntilChanged()
            .observeOn(ConcurrentMainScheduler.instance)
            .subscribe(onNext: { [weak self] loading in
                self?.loadingView.hidden(!loading)
            })
            .disposed(by: rx.disposeBag)

        listener?.searchModel.asObservable()
            .observeOn(ConcurrentMainScheduler.instance)
            .subscribe(onNext: { [weak self] searchModel in
                guard let me = self else { return }
                searchInputView.numberLable.text = searchModel.totalCountText
                me.searchModelRelay.accept(searchModel)
                me.tableView.reloadData()
            })
            .disposed(by: rx.disposeBag)

        // - MARK: SearchRouting

        // TODO: consider detach trigger
        ex.viewDidAppear
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.detachDetail()
            })
            .disposed(by: rx.disposeBag)

        tableViewDataSource.didTapCell
            .subscribe(onNext:{ [weak self] user in
                self?.listener?.routeToUser(user)
            })
            .disposed(by: rx.disposeBag)
    }
}

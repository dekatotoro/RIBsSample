//
//  GitHubAPI+SearchUser.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

import APIKit
import RxSwift

extension GitHubAPI {
    
    func searchUser(params: [String : Any]?) -> Observable<GitHubSearchUserResponse<[GitHubUser]>>  {
        let request = SearchUserRequest(customParams: params)

        let observable = Observable<GitHubSearchUserResponse<[GitHubUser]>>.create { observer -> Disposable in
            Session.send(request, callbackQueue: .main, handler: { result in
                switch result {
                case .success(let users):
                    observer.on(.next(users))
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            })
            return Disposables.create()
        }
        return observable.take(1)
    }

    func cancelSearchUser() {
        Session.cancelRequests(with: SearchUserRequest.self)
    }
}

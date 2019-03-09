//
//  GitHubAPI.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//

import APIKit
import RxSwift

protocol GitHubAPIType {
    func searchUser(params: [String : Any]?) -> Observable<GitHubSearchUserResponse<[GitHubUser]>>
    func cancelSearchUser()
}

final class GitHubAPI: GitHubAPIType {}

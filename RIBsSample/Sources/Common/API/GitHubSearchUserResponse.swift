//
//  GitHubSearchUserResponse.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

struct GitHubSearchUserResponse<T> {
    var resource: T
    var totalCount: Int?
    var incomplete_results: Bool
    var linkHeader: GitHubLinkHeader?
}

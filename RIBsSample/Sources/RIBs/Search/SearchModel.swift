//
//  SearchModel.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//

struct SearchModel<T> {
    
    var searchkey: String = ""
    var elements: [T] = []
    var totalCount: Int?
    var linkHeader: GitHubLinkHeader?
    
    static func make(from searchkey: String, gitHubSearchUserResponse: GitHubSearchUserResponse<[T]>) -> SearchModel {
        var searchModel = SearchModel<T>()
        searchModel.searchkey = searchkey
        searchModel.elements = gitHubSearchUserResponse.resource
        searchModel.totalCount = gitHubSearchUserResponse.totalCount
        searchModel.linkHeader = gitHubSearchUserResponse.linkHeader
        return searchModel
    }
    
    func concat(searchModel: SearchModel) -> SearchModel<T> {
        var new = SearchModel<T>()
        new.searchkey = searchModel.searchkey
        new.elements = (elements + searchModel.elements)
        new.totalCount = searchModel.totalCount
        new.linkHeader = searchModel.linkHeader
        return new
    }
    
    var nextPage: Int? {
        return linkHeader?.next?.page
    }
    
    var totalCountText: String {
        let count = totalCount ?? elements.count
        return "\(elements.count)/\(count)件"
    }
}

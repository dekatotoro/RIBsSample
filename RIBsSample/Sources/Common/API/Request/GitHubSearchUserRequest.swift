//
//  GitHubSearchUserRequest.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//

import APIKit

// https://developer.github.com/v3/users/followers/
struct SearchUserRequest: GitHubRequest {
    typealias Response = GitHubSearchUserResponse<[GitHubUser]>
    
    let customParams: [String : Any]?
    
    init(customParams: [String : Any]?) {
        self.customParams = customParams
    }

    let dataParser: DataParser = DecodableDataParser()

    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/search/users"
    }
    
    var queryParameters: [String : Any]? {
        return customParams
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        if let link = urlResponse.allHeaderFields.filter({ $0.key.description == "Link"}).first,
            let linkValue = link.value as? String {
            print(linkValue)
            
        }

        guard let data = object as? Data else { throw ApiResponseError.invalidData(object) }

        let decoder = JSONDecoder()
        let gitHubSearchUser = try decoder.decode(GitHubSearchUser.self, from: data)

        let linkHeader = headerParameters(urlResponse)
        let response = GitHubSearchUserResponse(resource: gitHubSearchUser.items,
                                      totalCount: gitHubSearchUser.totalCount,
                                      incomplete_results: gitHubSearchUser.incompleteResults,
                                      linkHeader: linkHeader)
        return response
    }
    
    func headerParameters(_ urlResponse: HTTPURLResponse) -> GitHubLinkHeader? {
        let linkHeader: GitHubLinkHeader?
        if let linkHeaderString = urlResponse.allHeaderFields["Link"] as? String {
            linkHeader = GitHubLinkHeader(string: linkHeaderString)
        } else {
            linkHeader = nil
        }
        return linkHeader
    }
}

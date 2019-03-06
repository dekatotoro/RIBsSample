//
//  GitHubAPI.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//

import APIKit
import RxSwift

protocol GitHubRequest: Request {}

extension GitHubRequest {
    var baseURL: URL {
        return URL(string: Config.gitHub.apiBaseURL)!
    }
    
    var headerFields: [String: String] {
        return ["Authorization": "token \(Config.gitHub.apiToken)",
                "Content-Type" : "application/json; charset=utf-8",
                "Accept" : "application/vnd.github.v3+json"]
    }
}

extension GitHubRequest where Response == Data {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ApiResponseError.invalidData(object)
        }
        return data
    }
}

final class GitHubAPI { }

enum ApiResponseError: Error {
    /// Received object is not Data
    case invalidData(Any)
}


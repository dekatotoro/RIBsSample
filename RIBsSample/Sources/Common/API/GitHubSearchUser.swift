//
//  GitHubSearchUser.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

struct GitHubSearchUser {
    var items: [GitHubUser]
    var totalCount: Int?
    var incompleteResults: Bool
}

extension GitHubSearchUser: Decodable {
    private enum CodingKeys: String, CodingKey {
        case items =  "items"
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([GitHubUser].self, forKey: .items)
        totalCount = try container.decodeIfPresent(Int.self, forKey: .totalCount)
        incompleteResults = try container.decode(Bool.self, forKey: .incompleteResults)
    }
}

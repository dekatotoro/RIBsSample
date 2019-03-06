//
//  GitHubUser.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//

struct GitHubUser {
    let name: String
    let url: String
    let imageUrl: String
}

extension GitHubUser: Decodable {

    private enum CodingKeys: String, CodingKey {
        case name = "login"
        case url = "url"
        case imageUrl =  "avatar_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(String.self, forKey: .url)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
    }
}

//
//  Config.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

struct Config {
    struct GitHub {
        let apiToken: String
        let apiBaseURL: String

        init() {
            apiToken = "your api token"
            apiBaseURL = "https://api.github.com"
        }
    }

    static let gitHub = GitHub()

}


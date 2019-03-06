//
//  DecodableDataParser.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019 dekatotoro. All rights reserved.
//

import APIKit

final class DecodableDataParser: DataParser {
    public var contentType: String? {
        return "application/json; charset=utf-8"
    }

    func parse(data: Data) throws -> Any {
        return data
    }
}


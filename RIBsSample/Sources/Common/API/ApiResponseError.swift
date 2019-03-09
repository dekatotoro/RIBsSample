//
//  ApiResponseError.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/09.
//  Copyright © 2019 Yuji Hato. All rights reserved.
//

import Foundation

enum ApiResponseError: Error {
    /// Received object is not Data
    case invalidData(Any)
}

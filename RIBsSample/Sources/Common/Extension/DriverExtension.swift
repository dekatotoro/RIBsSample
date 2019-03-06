//
//  DriverExtension.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//

import RxCocoa

extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy, E: OptionalType {

    func filterNil() -> Driver<E.Wrapped> {
        return flatMap { (item) -> Driver<E.Wrapped> in
            if let value = item.value {
                return .just(value)
            } else {
                return .empty()
            }
        }
    }
}

extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy, E: Collection {
    
    func filterEmpty() -> Driver<E> {
        return filter { !$0.isEmpty }
    }
}

//
//  ObservableTypeExtension.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//

import RxSwift
import RxCocoa

protocol OptionalType {
    associatedtype Wrapped
    
    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    var value: Wrapped? { return self }
}


extension ObservableType {
    
    func map<T>(_ behaviorRelay: BehaviorRelay<T>) -> Observable<T> {
        return map { _ in behaviorRelay.value }
    }
    
    func then<T>(_ observable: Observable<T>) -> Observable<T> {
        return flatMap { _ in observable }
    }
    
    func then<T>(_ closure: @escaping (() -> Observable<T>)) -> Observable<T> {
        return flatMap { _ in closure() }
    }
    
    func mapToOptional() -> Observable<Optional<E>> {
        return map { Optional($0) }
    }
    
}

extension ObservableType where E: OptionalType {

    func filterNil() -> Observable<E.Wrapped> {
        return flatMap { item -> Observable<E.Wrapped> in
            if let value = item.value {
                return Observable.just(value)
            } else {
                return Observable.empty()
            }
        }
    }
    
}

extension ObservableType where E: Collection {

    func filterEmpty() -> Observable<E> {
        return filter { !$0.isEmpty }
    }
    
}

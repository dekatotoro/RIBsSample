//
//  GitHubLinkHeader.swift
//  RIBsSample
//
//  Created by Yuji Hato on 2019/03/05.
//  Copyright © 2019年 dekatotoro. All rights reserved.
//
import Foundation

// https://developer.github.com/v3/#pagination
struct GitHubLinkHeader {
    let first: Element?
    let prev: Element?
    let next: Element?
    let last: Element?
    
    var hasFirstPage: Bool {
        return first != nil
    }
    
    var hasPrevPage: Bool {
        return prev != nil
    }
    
    var hasNextPage: Bool {
        return next != nil
    }
    
    var hasLastPage: Bool {
        return last != nil
    }
    
    init?(string: String) {
        let elements = string.components(separatedBy: ", ").compactMap { Element(string: $0) }
        
        first = elements.filter { $0.rel == "first" }.first
        prev = elements.filter { $0.rel == "prev" }.first
        next = elements.filter { $0.rel == "next" }.first
        last = elements.filter { $0.rel == "last" }.first
        
        if first == nil && prev == nil && next == nil && last == nil {
            return nil
        }
    }
}

extension GitHubLinkHeader {
    public struct Element {
        let uri: URL
        let rel: String
        let page: Int
        
        init?(string: String) {
            let attributes = string.components(separatedBy: "; ")
            guard attributes.count == 2 else {
                return nil
            }
            
            func trimString(_ string: String) -> String {
                guard string.count > 2 else {
                    return ""
                }
                return String(string[string.index(after: string.startIndex)..<string.index(before: string.endIndex)])
            }
            
            func value(_ field: String) -> String? {
                let pair = field.components(separatedBy: "=")
                guard pair.count == 2 else {
                    return nil
                }
                return trimString(pair.last!)
            }
            
            let uriString = attributes[0]
            guard let uri = URL(string: trimString(uriString)) else {
                return nil
            }
            
            self.uri = uri
            
            guard let rel = value(attributes[1]) else {
                return nil
            }
            self.rel = rel
            
            guard let queryItems = NSURLComponents(url: uri, resolvingAgainstBaseURL: true)?.queryItems else {
                return nil
            }
            guard queryItems.count > 0 else { return nil }
            let pageQueryItem = queryItems.filter({ $0.name == "page" }).first
            guard let value = pageQueryItem?.value,
                let page = Int(value) else {
                    return nil
            }
            self.page = page
        }
    }
}

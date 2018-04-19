//
//  URLExtentions.swift
//  ICExtentions
//
//  Created by INCHAN KANG on 2018. 4. 5..
//  Copyright © 2018년 INCHAN KANG. All rights reserved.
//

import Foundation

extension URL {

    /// SwifterSwift: URL initailize with appending query parameters
    ///         let param = ["first":"1  1"]
    ///         let url = URL(string: "https://google.com", queryParameters: param)
    ///         -> https://google.com?first=1
    init?(string: String, queryParameters: [String: String]) {
        var urlString = string
        if let url = URL(string: urlString) {
            if let query = url.appendingQueryParameters(queryParameters).query {
                urlString = urlString + "?" + query
            }
        }
        self.init(string: urlString)
    }
    
    /// 스위프터스위프트를 참고함.
    /// SwifterSwift: URL with appending query parameters.
    ///
    ///        let url = URL(string: "https://google.com")!
    ///        let param = ["q": "Swifter Swift"]
    ///        url.appendingQueryParameters(params) -> "https://google.com?q=Swifter%20Swift"
    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false), let queryItems = components.queryItems else { return nil }
        var items: [String: String] = [:]
        for queryItem in queryItems {
            items[queryItem.name] = queryItem.value
        }
        return items
    }
    
    /// 스위프터스위프트를 참고함.
    /// SwifterSwift: Append query parameters to URL.
    ///
    ///        var url = URL(string: "https://google.com")!
    ///        let param = ["q": "Swifter Swift"]
    ///        url.appendQueryParameters(params)
    ///        print(url) // prints "https://google.com?q=Swifter%20Swift"
    ///
    /// - Parameter parameters: parameters dictionary.
    public func appendingQueryParameters(_ parameters: [String: String]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        var items = urlComponents.queryItems ?? []
        items += parameters.map({ URLQueryItem(name: $0, value: $1) })
        urlComponents.queryItems = items
        return urlComponents.url!
    }

}

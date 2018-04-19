//
//  ICStringExtentions.swift
//  ICExtentions
//
//  Created by INCHAN KANG on 2018. 4. 4..
//  Copyright © 2018년 INCHAN KANG. All rights reserved.
//

import Foundation

// MARK: Encoding
public extension String {
    
    /// URL 인코딩
    /// String -> URL Encoded String
    ///
    public var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
    /// URL 디코딩
    /// URL Encoded String -> String
    ///
    public var urlDecoded: String {
        return removingPercentEncoding ?? self
    }

    /// Base64 인코딩
    /// String -> Base64 Encoded String
    ///
    public var base64Encoded: String? {
        return data(using: .utf8, allowLossyConversion: true)?.base64EncodedString(options: [])
    }
    
    /// Base64 디코딩
    /// Base64 Encoded String -> String
    ///
    public var base64Decoded: String? {
        guard let data = Data(base64Encoded: self, options: []) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// 트림
    ///
    /// remove whitespaces character
    ///
    public func trim(_ set: CharacterSet = CharacterSet.whitespaces) -> String {
        return trimmingCharacters(in: set)
    }
}

// MARK: Convert Type
public extension String {
    
    /// String -> URL
    ///
    ///     let urlString = "http://google.com"
    ///     urlString.url -> URL(string: urlString)
    /// 
    public var url: URL? {
        return URL(string: self)
    }
    
    /// String -> URLRequest
    ///
    ///     let urlString = "http://google.com"
    ///     urlString.request -> URLRequest(url: urlString.url!)
    ///
    public var request: URLRequest? {
        guard let url = self.url else { return nil }
        return URLRequest(url: url)
    }
    
    /// String -> Data
    ///
    ///     let urlString = "http://google.com"
    ///     urlString.data -> urlString.data(using: String.Encoding.utf8)
    ///
    public var data: Data? {
        return self.data(using: String.Encoding.utf8)
    }
    
    /// String -> Date
    ///
    ///     let dateString = "2018.04.05"
    ///     urlString.date(format: "yyyy.MM.dd") -> Optional(2018-01-04 15:04:00 +0000)
    ///
    public func date(format: String) -> Date? {
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = format
        return dateFomatter.date(from: self)
    }
}

// matches 
public extension String {
    
    /// 문자열에서 해당 문자열 또는 패턴을 검색하여 있는 여부 확인.
    ///
    public func matches(pattern: String) -> Bool {
        return range(of: pattern,
                     options: String.CompareOptions.regularExpression,
                     range: nil, locale: nil) != nil
    }
    
    /// 이메일 체크
    /// "email@domain.com".isEmail -> true
    /// "email@domaincom".isEmail -> false
    /// "emaildomain.com".isEmail -> false
    /// "emaildomaincom".isEmail -> false
    ///
    public var isEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        return matches(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
    }
    
    /// 문자열이 시작하는 Index 반환
    /// "abcdefg".indexOf(string:"c") -> Optional(2)
    ///
    public func indexOf(string: String) -> Int? {
        guard let range = range(of: string) else { return nil }
        return distance(from: startIndex, to: range.lowerBound)
    }

    /// Range에 해당하는 문자열을 반환
    /// "abcdefg"[0..<3] -> Optional("abc")
    ///
    public subscript (range: Range<Int>) -> String? {
        //Check for out of boundary condition
        if count < range.upperBound || count < range.lowerBound { return nil }
        
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(startIndex, offsetBy: range.upperBound)
        return String(self[start..<end])
    }

}

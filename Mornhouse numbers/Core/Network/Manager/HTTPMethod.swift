//
//  HTTPMethod.swift
//  Mornhouse numbers
//
//  Created by Іван Богоносюк on 16.12.2022.
//

import Foundation

struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    /// `CONNECT` method.
    static let connect = HTTPMethod(rawValue: "CONNECT")
    /// `DELETE` method.
    static let delete = HTTPMethod(rawValue: "DELETE")
    /// `GET` method.
    static let get = HTTPMethod(rawValue: "GET")
    /// `HEAD` method.
    static let head = HTTPMethod(rawValue: "HEAD")
    /// `OPTIONS` method.
    static let options = HTTPMethod(rawValue: "OPTIONS")
    /// `PATCH` method.
    static let patch = HTTPMethod(rawValue: "PATCH")
    /// `POST` method.
    static let post = HTTPMethod(rawValue: "POST")
    /// `PUT` method.
    static let put = HTTPMethod(rawValue: "PUT")
    /// `TRACE` method.
    static let trace = HTTPMethod(rawValue: "TRACE")

    let rawValue: String

    init(rawValue: String) {
        self.rawValue = rawValue
    }
}

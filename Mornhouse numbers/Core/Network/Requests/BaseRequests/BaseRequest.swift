//
//  BaseRequest.swift
//  Mornhouse numbers
//
//  Created by Іван Богоносюк on 16.12.2022.
//

import Foundation

protocol BaseRequest {
    var path: String { get set }
    var method: HTTPMethod { get set }
    var params: [String: Any]? { get set }
    var headers: [String: String]? { get set }
}

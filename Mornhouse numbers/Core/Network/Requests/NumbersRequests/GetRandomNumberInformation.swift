//
//  GetRandomNumberInformation.swift
//  Mornhouse numbers
//
//  Created by Іван Богоносюк on 16.12.2022.
//

import Foundation

// MARK: - GetRandomNumberInformation
struct GetRandomNumberInformation: BaseRequest {
    var path: String = "/random/math"
    var method: HTTPMethod = .get
    var params: [String: Any]?
    var headers: [String: String]?
}

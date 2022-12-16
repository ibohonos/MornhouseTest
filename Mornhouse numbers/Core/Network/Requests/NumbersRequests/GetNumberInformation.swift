//
//  GetNumberInformation.swift
//  Mornhouse numbers
//
//  Created by Іван Богоносюк on 16.12.2022.
//

import Foundation

// MARK: - GetNumberInformation
struct GetNumberInformation: BaseRequest {
    var path: String = "/"
    var method: HTTPMethod = .get
    var params: [String: Any]?
    var headers: [String: String]?
    
    init(number: String) {
        path += number
    }
}

//
//  GetNumberResponse.swift
//  Mornhouse numbers
//
//  Created by Іван Богоносюк on 16.12.2022.
//

import Foundation

struct GetNumberResponse: Codable {
    let text: String
    let number: Int
    let found: Bool
}

//
//  NetworkErrorMessage.swift
//  Mornhouse numbers
//
//  Created by Іван Богоносюк on 16.12.2022.
//

import Foundation

// MARK: - Errors
struct ErrorResponse: Codable {
    let success: Bool
    let errors: [String: String]
}

// MARK: - NetworkErrorMessage
struct NetworkErrorMessage: Error, Codable {
    var message: String?
    var code: Int?
    var errorsArray: [String]?
    var errors: String? {
        get {
            var messageString = ""
            if let message = message {
                messageString = message
            }
            guard let errors = errorsArray else { return messageString }
            if let result = executeStrings(fromArray: errors) {
                messageString = messageString + "\n" + result
            }
            return messageString
        }
    }
    
    init(dictionary dict: NSDictionary) {
        message = dict["message"] as? String
        code = dict["code"] as? Int
        errorsArray = executeErrors(dict)
    }
    
    init(error: ErrorResponse, code errorCode: Int) {
        let err = executeErrors(error.errors)

        message = err?.first
        code = errorCode
        errorsArray = err
    }
}

// MARK: - Private
private extension NetworkErrorMessage {
    func executeErrors(_ dict: NSDictionary) -> [String]? {
        guard let errors = dict["errors"] as? [String: [String]] else { return nil }
        var stringErrors: [String] = []

        for (_, value) in errors {
            guard let str = executeStrings(fromArray: value) else { continue }

            stringErrors.append(str)
        }

        return stringErrors.isEmpty ? nil : stringErrors
    }
    
    func executeErrors(_ errors: [String: String]) -> [String]? {
        var stringErrors: [String] = []

        for (key, value) in errors {
            stringErrors.append(key + ": " + value)
        }

        return stringErrors.isEmpty ? nil : stringErrors
    }
    
    func executeStrings(fromArray arr: [String]) -> String? {
        var resultString = ""

        for i in 0 ..< arr.count {
            if i == arr.count - 1 {
                resultString += "\(arr[i])"
                continue
            }

            resultString += "\(arr[i])\n"
        }

        return resultString.isEmpty ? nil : resultString
    }
}

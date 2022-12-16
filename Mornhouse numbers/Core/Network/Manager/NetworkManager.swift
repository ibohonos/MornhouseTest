//
//  NetworkManager.swift
//  Mornhouse numbers
//
//  Created by Іван Богоносюк on 16.12.2022.
//

import Foundation

class NetworkManager {
    // MARK: - Properties
    static let baseUrl: String = Bundle.main.object(forInfoDictionaryKey: "BaseUrl") as! String
    static let shared = NetworkManager()
    private let decoder = JSONDecoder()
    
    func perform<Value: Codable>(request: BaseRequest, baseUrl: String = NetworkManager.baseUrl) async throws -> Value {
        let startDate = Date()
        var urlRequest = try getParams(request: request, baseUrl: baseUrl)
        var headers = ["Accept": "application/json",
                       "Content-Type": "application/json"]
        if let requestHeaders = request.headers {
            headers.merge(requestHeaders) { (current, _) in current }
        }
        
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields?.merge(headers) { (current, _) in current }

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode >= 200,
                httpResponse.statusCode < 300 else {
            let error = try decoder.decode(ErrorResponse.self, from: data)
            
            throw NetworkErrorMessage(error: error, code: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }
        guard let decodedResponse = try? decoder.decode(Value.self, from: data) else {
            throw NetworkErrorMessage(dictionary: ["message": "Data parsing error"])
        }

        return decodedResponse
    }
}

// MARK: - Private
private extension NetworkManager {
    func getParams(request: BaseRequest, baseUrl: String = NetworkManager.baseUrl) throws -> URLRequest {
        guard let url = URL(string: baseUrl + request.path) else { throw NetworkErrorMessage(dictionary: ["message": "Missing URL"]) }
        var urlRequest = URLRequest(url: url)
        
        if [HTTPMethod.get, .head, .delete].contains(request.method) {
            guard let url = urlRequest.url else {
                throw NetworkErrorMessage(dictionary: ["message": "Missing URL"])
            }

            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !(request.params?.isEmpty ?? true) {
                let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(request.params ?? [:])
                urlComponents.percentEncodedQuery = percentEncodedQuery
                urlRequest.url = urlComponents.url
            }
        } else {
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }

            urlRequest.httpBody = Data(query(request.params ?? [:]).utf8)
        }
        
        return urlRequest
    }
    
    func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []

        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!

            components += queryComponents(fromKey: key, value: value)
        }

        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
    /// Creates a percent-escaped, URL encoded query string components from the given key-value pair recursively.
    ///
    /// - Parameters:
    ///   - key:   Key of the query component.
    ///   - value: Value of the query component.
    ///
    /// - Returns: The percent-escaped, URL encoded query string components.
    func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []

        switch value {
            case let dictionary as [String: Any]:
                for (nestedKey, value) in dictionary {
                    components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
                }
            default:
                components.append((escape(key), escape("\(value)")))
        }

        return components
    }
    
    /// Creates a percent-escaped string following RFC 3986 for a query string key or value.
    ///
    /// - Parameter string: `String` to be percent-escaped.
    ///
    /// - Returns:          The percent-escaped `String`.
    func escape(_ string: String) -> String {
        string.addingPercentEncoding(withAllowedCharacters: .URLQueryAllowed) ?? string
    }
}

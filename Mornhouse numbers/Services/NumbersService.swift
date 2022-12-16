//
//  NumbersService.swift
//  Mornhouse numbers
//
//  Created by Іван Богоносюк on 16.12.2022.
//

import Foundation

protocol NumbersServiceProtocol: AnyObject {
    func getNumberInfo(number: String) async throws -> GetNumberResponse
    func getRandomNumber() async throws -> GetNumberResponse
}

final class NumbersService: NumbersServiceProtocol {
    static let shared = NumbersService()
    private var networkManager = NetworkManager.shared
    
    func getNumberInfo(number: String) async throws -> GetNumberResponse {
        let request = GetNumberInformation(number: number)
        
        return try await networkManager.perform(request: request)
    }
    
    func getRandomNumber() async throws -> GetNumberResponse {
        let request = GetRandomNumberInformation()
        
        return try await networkManager.perform(request: request)
    }
}

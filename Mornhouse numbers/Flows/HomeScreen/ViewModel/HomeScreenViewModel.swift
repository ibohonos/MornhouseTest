//
//  HomeScreenViewModel.swift
//  Mornhouse numbers
//
//  Created by Іван Богоносюк on 16.12.2022.
//

import Foundation
import RealmSwift

final class HomeScreenViewModel: ObservableObject {
    @Published var text = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func loadNumber() {
        guard !text.isEmpty, text.range(of: "^[0-9]*$", options: .regularExpression) != nil else { return }
        
        let number = text
        text = ""
        
        Task {
            do {
                let response = try await NumbersService.shared.getNumberInfo(number: number)
                try await saveResponse(response)
            } catch {
                print(error.localizedDescription)
                await configAlert(error.localizedDescription)
            }
        }
    }
    
    func loadRandomNumber() {
        Task {
            do {
                let response = try await NumbersService.shared.getRandomNumber()
                try await saveResponse(response)
            } catch {
                print(error.localizedDescription)
                await configAlert(error.localizedDescription)
            }
        }
    }
}

// MARK: - private
private extension HomeScreenViewModel {
    @MainActor
    func saveResponse(_ response: GetNumberResponse) throws {
        let realm = try Realm()
        
        if response.found {
            var fact: Fact {
                let fact = Fact()
                
                fact.fact = response.text
                fact.number = "\(response.number)"
                
                return fact
            }
            
            try realm.write({
                realm.add(fact)
            })
            
            return
        }

        configAlert(response.text)
    }
    
    @MainActor
    func configAlert(_ text: String) {
        alertMessage = text
        showAlert = true
    }
}

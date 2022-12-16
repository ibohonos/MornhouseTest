//
//  HomeScreenView.swift
//  Mornhouse numbers
//
//  Created by Іван Богоносюк on 16.12.2022.
//

import SwiftUI
import RealmSwift

struct HomeScreenView: View {
    @StateObject private var viewModel = HomeScreenViewModel()
    @ObservedResults(Fact.self, sortDescriptor: .init(keyPath: "id", ascending: false)) var facts
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                TextField("Enter number", text: $viewModel.text)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                
                Button(action: viewModel.loadNumber) {
                    Text("Get fact")
                        .defaultButton()
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 15)
            
            Button(action: viewModel.loadRandomNumber) {
                Text("Get fact about random number")
                    .defaultButton()
            }
            .padding([.horizontal, .bottom], 15)
            
            List(facts) { fact in
                NavigationLink(destination: DetailScreenView(fact: fact)) {
                    Text(fact.fact)
                        .lineLimit(1)
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert, content: {
            Alert(title: Text(viewModel.alertMessage))
        })
        .navigationTitle("Mornhouse numbers")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeScreenView()
        }
    }
}

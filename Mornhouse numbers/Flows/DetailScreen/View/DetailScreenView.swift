//
//  DetailScreenView.swift
//  Mornhouse numbers
//
//  Created by Іван Богоносюк on 16.12.2022.
//

import SwiftUI
import RealmSwift

struct DetailScreenView: View {
    @ObservedRealmObject var fact: Fact

    var body: some View {
        VStack {
            Text(fact.fact)
        }
        .padding(20)
        .navigationTitle("Number is \(fact.number)")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct DetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailScreenView(fact: Fact.ten)
        }
    }
}

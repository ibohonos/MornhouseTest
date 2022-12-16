//
//  Fact.swift
//  Mornhouse numbers
//
//  Created by Іван Богоносюк on 16.12.2022.
//

import Foundation
import RealmSwift

class Fact: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var fact = ""
    @Persisted var number = ""
}

extension Fact {
    static var ten: Fact {
        let fact = Fact()
        
        fact.fact = "10 is the number of hydrogen atoms in butane, a hydrocarbon."
        fact.number = "10"
        
        return fact
    }
    
    static var twelve: Fact {
        let fact = Fact()
        
        fact.fact = "12 is the number of months in a year."
        fact.number = "12"
        
        return fact
    }
    
    static let exampleData = [
        ten,
        twelve
    ]
}

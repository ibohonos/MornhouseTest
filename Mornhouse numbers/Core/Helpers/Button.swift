//
//  Button.swift
//  Mornhouse numbers
//
//  Created by Іван Богоносюк on 16.12.2022.
//

import Foundation
import SwiftUI

extension Text {
    func defaultButton(isDisabled: Bool = false) -> some View {
        return self
            .padding(.vertical, 5)
            .padding(.horizontal, 15)
            .background(Color.blue.opacity(isDisabled ? 0.5 : 1))
            .foregroundColor(.white)
            .clipShape(Capsule(style: .continuous))
    }
}

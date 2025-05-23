//
//  Binding+EXT.swift
//  ArchitectureBootcamp
//
//  Created by Andres Raigoza on 20/05/25.
//

import SwiftUI

extension Binding where Value == Bool {
    init<T: Sendable>(ifNotNil value: Binding<T?>) {
        self.init(get: {
            value.wrappedValue != nil
        }, set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        })
    }
}

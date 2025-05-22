//
//  AnyDestination.swift
//  ArchitectureBootcamp
//
//  Created by Andres Raigoza on 20/05/25.
//

import SwiftUI

public struct AnyDestination: Hashable, @unchecked Sendable {
    let id = UUID()
    var destination: AnyView
    
    public init<T: View>(destination: T) {
        self.destination = AnyView(destination)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: AnyDestination, rhs: AnyDestination) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

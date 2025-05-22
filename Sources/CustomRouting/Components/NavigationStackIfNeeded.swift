//
//  NavigationStackIfNeeded.swift
//  ArchitectureBootcamp
//
//  Created by Andres Raigoza on 20/05/25.
//

import SwiftUI

struct NavigationStackIfNeeded<Content: View>: View {
    @Binding var path: [AnyDestination]
    var addNavigationStack = true
    @ViewBuilder var content: Content
    
    var body: some View {
        if addNavigationStack {
            NavigationStack(path: $path) {
                content
                    .navigationDestination(for: AnyDestination.self) { value in
                        value.destination
                    }
            }
        } else {
            content
        }
    }
}

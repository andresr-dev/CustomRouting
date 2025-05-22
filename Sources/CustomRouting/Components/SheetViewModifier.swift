//
//  SheetViewModifier.swift
//  ArchitectureBootcamp
//
//  Created by Andres Raigoza on 20/05/25.
//

import SwiftUI

extension View {
    func sheetViewModifier(screen: Binding<AnyDestination?>) -> some View {
        sheet(isPresented: Binding(ifNotNil: screen)) {
            if let screen = screen.wrappedValue {
                screen.destination
            }
        }
    }
    
    func fullScreenCoverViewModifier(screen: Binding<AnyDestination?>) -> some View {
        fullScreenCover(isPresented: Binding(ifNotNil: screen)) {
            if let screen = screen.wrappedValue {
                screen.destination
            }
        }
    }
    
    func anyView() -> AnyView {
        AnyView(self)
    }
}

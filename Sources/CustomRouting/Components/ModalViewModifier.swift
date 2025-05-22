//
//  ModalViewModifier.swift
//  ArchitectureBootcamp
//
//  Created by Andres Raigoza on 21/05/25.
//

import SwiftUI

struct ModalSupportView<Content: View>: View {
    let backgroundColor: Color
    let transition: AnyTransition
    @Binding var showModal: Bool
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            if showModal {
                backgroundColor
                    .ignoresSafeArea()
                    .transition(.opacity.animation(.smooth))
                    .onTapGesture {
                        showModal = false
                    }
                    .zIndex(1)
                
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .transition(transition)
                    .zIndex(2)
            }
        }
        .zIndex(9999)
        .animation(.bouncy, value: showModal)
    }
}

extension View {
    func modalViewModifier(
        backgroundColor: Color,
        transition: AnyTransition,
        screen: Binding<AnyDestination?>
    ) -> some View {
        overlay {
            ModalSupportView(backgroundColor: backgroundColor, transition: transition, showModal: Binding(ifNotNil: screen)) {
                ZStack {
                    if let screen = screen.wrappedValue {
                        screen.destination
                    }
                }
            }
        }
    }
}

//
//  RouterView.swift
//  ArchitectureBootcamp
//
//  Created by Andres Raigoza on 20/05/25.
//

import SwiftUI

public struct RouterView<Content: View>: View, Router {
    @Environment(\.dismiss) private var dismiss
    
    @State private var showSheet: AnyDestination?
    @State private var showFullScreenCover: AnyDestination?
    
    @State private var alert: AnyAppAlert?
    @State private var alertOption: AlertType = .alert
    
    @State private var modalBackgroundColor = Color.black.opacity(0.6)
    @State private var modalTransition = AnyTransition.opacity
    @State private var modal: AnyDestination?
    
    @State private var path = [AnyDestination]()
    @Binding var screenStack: [AnyDestination]
    
    var addNavigationStack = true
    @ViewBuilder var content: (Router) -> Content
    
    public init(
        screenStack: (Binding<[AnyDestination]>)? = nil,
        addNavigationStack: Bool = true,
        content: @escaping (Router) -> Content
    ) {
        self._screenStack = screenStack ?? .constant([])
        self.addNavigationStack = addNavigationStack
        self.content = content
    }

    public var body: some View {
        NavigationStackIfNeeded(path: $path, addNavigationStack: addNavigationStack) {
            content(self)
                .sheetViewModifier(screen: $showSheet)
                .fullScreenCoverViewModifier(screen: $showFullScreenCover)
                .showCustomAlert(type: alertOption, alert: $alert)
        }
        .modalViewModifier(backgroundColor: modalBackgroundColor, transition: modalTransition, screen: $modal)
        .environment(\.router, self)
    }
    
    public func showScreen<T: View>(_ option: SegueOption, @ViewBuilder destination: @escaping (Router) -> T) {
        let screen = RouterView<T>(
            screenStack: option.shouldAddNavigationStack ? nil : screenStack.isEmpty ? $path : $screenStack,
            addNavigationStack: option.shouldAddNavigationStack
        ) { router in
            destination(router)
        }

        let destination = AnyDestination(destination: screen)
        switch option {
        case .push:
            if screenStack.isEmpty {
                // We are in the first RouterView
                path.append(destination)
            } else {
                screenStack.append(destination)
            }
        case .sheet:
            showSheet = destination
        case .fullScreenCover:
            showFullScreenCover = destination
        }
    }
    
    public func dismissScreen() {
        dismiss()
    }
    
    public func showAlert(_ option: AlertType, title: String, subtitle: String? = nil, buttons: (@Sendable  () -> AnyView)? = nil) {
        alertOption = option
        alert = AnyAppAlert(title: title, subtitle: subtitle, buttons: buttons)
    }
    
    public func dismissAlert() {
        alert = nil
    }
    
    public func showModal<T: View>(backgroundColor: Color, transition: AnyTransition, @ViewBuilder destination: @escaping () -> T) {
        self.modalBackgroundColor = backgroundColor
        self.modalTransition = transition
        let destination = AnyDestination(destination: destination())
        modal = destination
    }
    
    public func dismissModal() {
        modal = nil
    }
}

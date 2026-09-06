//
// Copyright © 2021 Alexander Romanov
// ExampleApp.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

@main
struct ExampleApp: App {
    @Environment(\.theme) private var theme

    #if !os(watchOS)
    var body: some Scene {
        WindowGroup {
            rootView
        }
    }
    #else
    @SceneBuilder var body: some Scene {
        WindowGroup {
            rootView
        }
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
    #endif

    private var rootView: some View {
        NavigationStack {
            ComponentsList()
        }
        .preferredColorScheme(theme.appearance.colorScheme)
        #if os(iOS)
        .accentColor(theme.accentColor)
        #endif
        .theme(ThemeSettings())
    }
}

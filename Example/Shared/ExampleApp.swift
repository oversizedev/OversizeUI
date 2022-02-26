//
// Copyright © 2022 Alexander Romanov
// ExampleApp.swift
//

import OversizeUI
import SwiftUI

@main
struct ExampleApp: App {
    @Environment(\.theme) var theme

    #if !os(watchOS)
        var body: some Scene {
            WindowGroup {
                #if os(iOS)
                    ComponentsList()
                        .preferredColorScheme(theme.appearance.colorScheme)
                        .accentColor(theme.accentColor)
                        .theme(ThemeSettings())
                #else
                    ComponentsList()
                        .preferredColorScheme(theme.appearance.colorScheme)
                        .theme(ThemeSettings())
                #endif
            }
        }
    #else
        @SceneBuilder var body: some Scene {
            WindowGroup {
                ComponentsList()
            }
            WKNotificationScene(controller: NotificationController.self, category: "myCategory")
        }
    #endif
}

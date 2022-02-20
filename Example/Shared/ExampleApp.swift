//
// Copyright © 2022 Alexander Romanov
// ExampleApp.swift
//

import OversizeUI
import SwiftUI

@main
struct ExampleApp: App {
    @ObservedObject var appearanceSettings = AppearanceSettings.shared

    #if !os(watchOS)
        var body: some Scene {
            WindowGroup {
                #if os(iOS)
                    ComponentsList()
                        .preferredColorScheme(appearanceSettings.appearance.colorScheme)
                        .accentColor(appearanceSettings.accentColor)
                #else
                    ComponentsList()
                        .preferredColorScheme(appearanceSettings.appearance.colorScheme)
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

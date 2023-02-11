//
// Copyright © 2021 Alexander Romanov
// ExampleApp.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

@main
struct ExampleApp: App {
    @Environment(\.theme) var theme

    #if !os(watchOS)
        var body: some Scene {
            WindowGroup {
                GeometryReader { geometry in
                    #if os(iOS)
                        ComponentsList()
                            .preferredColorScheme(theme.appearance.colorScheme)
                            .accentColor(theme.accentColor)
                            .theme(ThemeSettings())
                            .screenSize(geometry)
                    #else
                        ComponentsList()
                            .preferredColorScheme(theme.appearance.colorScheme)
                            .theme(ThemeSettings())
                            .screenSize(geometry)
                    #endif
                }
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

#if os(iOS)
    extension UINavigationController: UIGestureRecognizerDelegate {
        override open func viewDidLoad() {
            super.viewDidLoad()
            interactivePopGestureRecognizer?.delegate = self
        }

        public func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
            viewControllers.count > 1
        }
    }
#endif

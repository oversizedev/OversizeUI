//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public enum AppearanceSettingsNames {
    public static var appearance = "Settings.Appearance"
    public static var accentColor = "Settings.AccentColor"
    public static var fontTitle = "Settings.FontTitle"
    public static var fontParagraph = "Settings.FontParagraph"
    public static var fontButton = "Settings.FontButton"
    public static var fontOverline = "Settings.FontOverline"
    public static var borderApp = "Settings.BorderApp"
    public static var borderButtons = "Settings.BorderButtons"
    public static var borderSurface = "Settings.BorderSurface"
    public static var borderTextFields = "Settings.BorderTextFields"
    public static var borderControls = "Settings.BorderControls"
    public static var borderSize = "Settings.BorderSize"
    public static var theme = "Settings.Theme"
    public static var radius = "Settings.Radius"
}

// swiftlint:disable trailing_comma opening_brace
public final class AppearanceSettings: ObservableObject {
    private init() {}

    public static let shared = AppearanceSettings()

    @AppStorage(AppearanceSettingsNames.appearance) public var appearance: Appearance = .light

    #if os(iOS)
        @AppStorage(AppearanceSettingsNames.accentColor) public var accentColor = Color.blue
    #endif

    @AppStorage(AppearanceSettingsNames.fontTitle) public var fontTitle: FontDesignType = .default
    @AppStorage(AppearanceSettingsNames.fontParagraph) public var fontParagraph: FontDesignType = .default
    @AppStorage(AppearanceSettingsNames.fontButton) public var fontButton: FontDesignType = .default
    @AppStorage(AppearanceSettingsNames.fontOverline) public var fontOverline: FontDesignType = .default

    @AppStorage(AppearanceSettingsNames.borderApp) public var borderApp: Bool = false
    @AppStorage(AppearanceSettingsNames.borderButtons) public var borderButtons: Bool = false
    @AppStorage(AppearanceSettingsNames.borderSurface) public var borderSurface: Bool = false
    @AppStorage(AppearanceSettingsNames.borderTextFields) public var borderTextFields: Bool = false
    @AppStorage(AppearanceSettingsNames.borderControls) public var borderControls: Bool = false

    @AppStorage(AppearanceSettingsNames.borderSize) public var borderSize: Double = 0.5

    @AppStorage(AppearanceSettingsNames.radius) public var radius: Double = 8

    @AppStorage(AppearanceSettingsNames.theme) public var theme: Int = 0

    public let themes: [Theme] = [
        Theme(id: 0, name: "Black", accentColor: .primary),
        Theme(id: 0, name: "Blue", accentColor: .accent),
    ]
}

#if os(iOS)
    public class AppIconSettings: ObservableObject {
        public var iconNames: [String?] = [nil]
        @Published public var currentIndex = 0

        public init() {
            getAlternateIconNames()

            if let currentIcon = UIApplication.shared.alternateIconName {
                currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
            }
        }

        private func getAlternateIconNames() {
            if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
               let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any]
            {
                for (_, value) in alternateIcons {
                    guard let iconList = value as? [String: Any] else { return }
                    guard let iconFiles = iconList["CFBundleIconFiles"] as? [String] else { return }
                    guard let icon = iconFiles.first else { return }

                    iconNames.append(icon)
                }
            }
        }
    }
#endif

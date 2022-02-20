//
// Copyright © 2022 Alexander Romanov
// ThemeSettings.swift
//

import SwiftUI

public enum ThemeSettingsNames {
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

public class ThemeSettings {
    public init() {}

    @AppStorage(ThemeSettingsNames.appearance) public var appearance: Appearance = .light

    #if os(iOS)
        @AppStorage(ThemeSettingsNames.accentColor) public var accentColor: Color = .blue
    #endif

    @AppStorage(ThemeSettingsNames.fontTitle) public var fontTitle: FontDesignType = .default
    @AppStorage(ThemeSettingsNames.fontParagraph) public var fontParagraph: FontDesignType = .default
    @AppStorage(ThemeSettingsNames.fontButton) public var fontButton: FontDesignType = .default
    @AppStorage(ThemeSettingsNames.fontOverline) public var fontOverline: FontDesignType = .default

    @AppStorage(ThemeSettingsNames.borderApp) public var borderApp: Bool = false
    @AppStorage(ThemeSettingsNames.borderButtons) public var borderButtons: Bool = false
    @AppStorage(ThemeSettingsNames.borderSurface) public var borderSurface: Bool = false
    @AppStorage(ThemeSettingsNames.borderTextFields) public var borderTextFields: Bool = false
    @AppStorage(ThemeSettingsNames.borderControls) public var borderControls: Bool = false

    @AppStorage(ThemeSettingsNames.borderSize) public var borderSize: Double = 0.5

    @AppStorage(ThemeSettingsNames.radius) public var radius: Double = 8

    @AppStorage(ThemeSettingsNames.theme) public var theme: Int = 0

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

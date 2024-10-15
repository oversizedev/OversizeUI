//
// Copyright © 2021 Alexander Romanov
// ThemeSettings.swift, created on 11.09.2021
//

import SwiftUI

public enum ThemeSettingsNames: Sendable {
    public static let appearance = "Settings.Appearance"
    public static let accentColor = "Settings.AccentColor"
    public static let fontTitle = "Settings.FontTitle"
    public static let fontParagraph = "Settings.FontParagraph"
    public static let fontButton = "Settings.FontButton"
    public static let fontOverline = "Settings.FontOverline"
    public static let borderApp = "Settings.BorderApp"
    public static let borderButtons = "Settings.BorderButtons"
    public static let borderSurface = "Settings.BorderSurface"
    public static let borderTextFields = "Settings.BorderTextFields"
    public static let borderControls = "Settings.BorderControls"
    public static let borderSize = "Settings.BorderSize"
    public static let theme = "Settings.Theme"
    public static let radius = "Settings.Radius"
}

public class ThemeSettings: ObservableObject, @unchecked Sendable {
    public init() {}

    @AppStorage(ThemeSettingsNames.appearance) public var appearance: Appearance = .system

    #if os(iOS)
    @AppStorage(ThemeSettingsNames.accentColor) public var accentColor: Color = .blue
    #endif

    @AppStorage(ThemeSettingsNames.fontTitle) public var fontTitle: FontDesignType = .default
    @AppStorage(ThemeSettingsNames.fontParagraph) public var fontParagraph: FontDesignType = .default
    @AppStorage(ThemeSettingsNames.fontButton) public var fontButton: FontDesignType = .default
    @AppStorage(ThemeSettingsNames.fontOverline) public var fontOverline: FontDesignType = .default

    @AppStorage(ThemeSettingsNames.borderApp) public var borderApp: Bool = false
    @AppStorage(ThemeSettingsNames.borderButtons) public var borderButtons: Bool = false
    #if os(macOS)
    @AppStorage(ThemeSettingsNames.borderTextFields) public var borderTextFields: Bool = true
    @AppStorage(ThemeSettingsNames.borderSurface) public var borderSurface: Bool = true
    #else
    @AppStorage(ThemeSettingsNames.borderSurface) public var borderSurface: Bool = false
    @AppStorage(ThemeSettingsNames.borderTextFields) public var borderTextFields: Bool = false
    #endif

    @AppStorage(ThemeSettingsNames.borderControls) public var borderControls: Bool = false

    @AppStorage(ThemeSettingsNames.borderSize) public var borderSize: Double = 0.5

    @AppStorage(ThemeSettingsNames.radius) public var radius: Double = 8

    @AppStorage(ThemeSettingsNames.theme) public var theme: Int = 0

    public let themes: [Theme] = [
        Theme(id: 0, name: "Black", accentColor: .primary),
        Theme(id: 0, name: "Blue", accentColor: .accent),
    ]
}

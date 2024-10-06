//
// Copyright © 2021 Alexander Romanov
// ThemeSettings.swift, created on 11.09.2021
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

public class ThemeSettings: ObservableObject {
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

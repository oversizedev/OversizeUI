//
// Copyright © 2026 Alexander Romanov
// Demos.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct DemoDescriptor: Identifiable {
    let id: UUID = .init()
    let title: String
    let screen: AnyView

    init(_ title: String, _ screen: some View) {
        self.title = title
        self.screen = AnyView(screen)
    }
}

struct DemoSection: Identifiable {
    let id: UUID = .init()
    let title: String
    let demos: [DemoDescriptor]
}

enum Demos {
    static var layouts: [DemoDescriptor] {
        var demos: [DemoDescriptor] = []
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, *) {
            demos.append(DemoDescriptor("Layout", LayoutDemo()))
            demos.append(DemoDescriptor("ListLayout", ListLayoutDemo()))
            demos.append(DemoDescriptor("CoverLayout", CoverLayoutDemo()))
            demos.append(DemoDescriptor("ListCoverLayout", ListCoverLayoutDemo()))
            #if os(iOS)
            demos.append(DemoDescriptor("CalendarLayout", CalendarLayoutDemo()))
            #endif
        }
        return demos
    }

    static var controls: [DemoDescriptor] {
        var demos: [DemoDescriptor] = [
            DemoDescriptor("Buttons", ButtonsDemo()),
            DemoDescriptor("Avatar", AvatarDemo()),
            DemoDescriptor("Badge", BadgeDemo()),
            DemoDescriptor("Row", RowDemo()),
            DemoDescriptor("ListRow", ListRowDemo()),
            DemoDescriptor("Surface", SurfaceDemo()),
            DemoDescriptor("Separator", SeparatorDemo()),
            DemoDescriptor("SegmentedControl", SegmentedControlDemo()),
            DemoDescriptor("GridSelect", GridSelectDemo()),
            DemoDescriptor("Stacks", StacksDemo()),
            DemoDescriptor("PageIndex", PageIndexDemo()),
            DemoDescriptor("PremiumLabel", PremiumLabelDemo()),
            DemoDescriptor("CachedAsyncImage", CachedAsyncImageDemo()),
        ]
        #if !os(watchOS) && !os(tvOS)
        demos.append(DemoDescriptor("ColorSelector", ColorSelectorDemo()))
        #endif
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) {
            demos.append(DemoDescriptor("Select", SelectDemo()))
        }
        return demos
    }

    static var toggles: [DemoDescriptor] {
        [
            DemoDescriptor("Checkbox", CheckboxDemo()),
            DemoDescriptor("Radio", RadioDemo()),
            DemoDescriptor("Switch", SwitchDemo()),
        ]
    }

    static var fields: [DemoDescriptor] {
        var demos: [DemoDescriptor] = [
            DemoDescriptor("TextField", TextFieldDemo()),
            DemoDescriptor("TextBox", TextBoxDemo()),
        ]
        #if os(iOS)
        if #available(iOS 17.0, *) {
            demos.append(DemoDescriptor("DateField", DateFieldDemo()))
        }
        demos.append(DemoDescriptor("PhoneField", PhoneFieldDemo()))
        #endif
        #if os(iOS) || os(macOS)
        if #available(iOS 16.0, macOS 14.0, *) {
            demos.append(DemoDescriptor("PriceField", PriceFieldDemo()))
        }
        if #available(iOS 15.0, macOS 14.0, *) {
            demos.append(DemoDescriptor("URLField", URLFieldDemo()))
        }
        #endif
        return demos
    }

    static var feedback: [DemoDescriptor] {
        var demos: [DemoDescriptor] = [
            DemoDescriptor("Notice", NoticeDemo()),
            DemoDescriptor("HUD", HUDDemo()),
            DemoDescriptor("Snackbar", SnackbarDemo()),
            DemoDescriptor("Loader", LoaderDemo()),
        ]
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) {
            demos.append(DemoDescriptor("Status", StatusDemo()))
        }
        demos.append(DemoDescriptor("ContentView", ContentViewDemo()))
        return demos
    }

    static var designSystem: [DemoDescriptor] {
        [
            DemoDescriptor("Colors", ColorsDemo()),
            DemoDescriptor("Typography", TypographyDemo()),
            DemoDescriptor("Spacing", SpacingDemo()),
            DemoDescriptor("Elevation", ElevationDemo()),
            DemoDescriptor("Icons", IconsDemo()),
        ]
    }

    static var sections: [DemoSection] {
        [
            DemoSection(title: "Layouts", demos: layouts),
            DemoSection(title: "Controls", demos: controls),
            DemoSection(title: "Toggles", demos: toggles),
            DemoSection(title: "Fields", demos: fields),
            DemoSection(title: "Feedback", demos: feedback),
            DemoSection(title: "Design System", demos: designSystem),
        ]
        .filter { $0.demos.isEmpty == false }
    }

    static var all: [DemoDescriptor] {
        sections.flatMap(\.demos)
    }
}

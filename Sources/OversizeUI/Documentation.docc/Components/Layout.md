# Layout

A scrolling screen built from native SwiftUI sections, styled by the design system.

## Overview

``Layout`` is the foundation of the layout system. It takes native SwiftUI `Section`s as its
content and renders them with the design system's spacing, separators, borders and backgrounds,
so a screen reads like a plain SwiftUI declaration while looking consistent across the app.

> Availability: iOS 18, macOS 15, tvOS 18, watchOS 11 and visionOS 2.

## Basic Usage

```swift
NavigationStack {
    Layout("Settings") {
        Section("Account") {
            Row("Profile")
            Row("Privacy")
        }

        Section("Notifications") {
            Row("Push")
            Row("Email")
        }
    }
    .listLayoutStyle(.insetGrouped)
}
```

The first argument becomes the screen's `navigationTitle`.

## Section Headers and Footers

Sections accept the full native API, including separate header and footer builders:

```swift
Layout("Sync") {
    Section {
        Row("Background refresh")
    } header: {
        Text("Data")
    } footer: {
        Text("Turning this off stops background refresh for every account.")
    }
}
```

## Styling

### List style

``ListLayoutStyle`` controls the overall grouping and insets:

```swift
Layout("Library") { ... }
    .listLayoutStyle(.insetGrouped)
```

| Style | Description |
|---|---|
| `.plain` | Edge-to-edge rows on the primary background |
| `.inset` | Inset rows without grouping |
| `.insetGrouped` | Rounded, inset groups on the secondary background |
| `.smallInsetGrouped` | Tighter variant of `.insetGrouped` |
| `.grouped` | Grouped rows with full-width separators |

### Section styling

Section-level modifiers can be applied to the whole layout or to a single `Section`:

```swift
Layout("Groups") {
    Section("Recent") {
        Row("Design")
        Row("Engineering")
    }
    .sectionTitlePosition(.outside)

    Section("New") {
        Button("Create a group") {}
    }
    .sectionBackgroundStyle(.dotted)
}
.sectionTitlePosition(.inside)
.sectionTitleSeparator(.visible)
.bordered()
```

| Modifier | Values |
|---|---|
| ``SwiftUI/View/sectionTitlePosition(_:)`` | `.inside`, `.outside` |
| ``SwiftUI/View/sectionTitleSeparator(_:)`` | `.visible`, `.hidden` |
| ``SwiftUI/View/sectionBackgroundStyle(_:)`` | `.surface`, `.dotted` |
| ``SwiftUI/View/bordered(_:)`` | Toggles section borders |

### Section actions

Attach trailing buttons to a section header:

```swift
Section("Playlists") {
    Row("Favourites")
}
.sectionActions {
    Button("Add") {}
    Button("Edit") {}
}
```

## Custom Background

```swift
Layout("Profile") {
    Section {
        Row("Account")
    }
} background: {
    LinearGradient(
        colors: [.accent, .backgroundSecondary],
        startPoint: .top,
        endPoint: .bottom
    )
}
```

## Scroll Tracking

The `onScroll` closure reports the content offset and how much of the header is still visible,
which is useful for fading a custom navigation bar in and out:

```swift
Layout("Album", onScroll: { offset, headerVisibleRatio in
    isTitleVisible = headerVisibleRatio < 0.5
}) {
    Section {
        Row("Track 1")
    }
}
```

## Topics

### Related layouts

- ``ListLayout``
- ``CoverLayout``
- ``ListCoverLayout``
- ``CalendarLayout``

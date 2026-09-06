# Sections

Group related content inside a layout using native SwiftUI sections.

## Overview

Sections in OversizeUI are plain SwiftUI `Section`s. ``Layout`` reads them and applies the design
system's titles, separators, borders and backgrounds, so there is no bespoke section type to
learn — the styling comes from modifiers.

> Availability: section styling applies inside ``Layout``, ``CoverLayout`` and ``CalendarLayout``,
> which require iOS 18, macOS 15, tvOS 18, watchOS 11 or visionOS 2. In ``ListLayout`` and
> ``ListCoverLayout``, use ``ListSection``.

## Basic Usage

```swift
Layout("Settings") {
    Section("Account") {
        Row("Profile")
        Row("Privacy")
        Row("Security")
    }
}
```

## Headers and Footers

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

## Title Position

Titles sit either inside the section's surface or above it:

```swift
Section("Inside") {
    Row("Item")
}
.sectionTitlePosition(.inside)

Section("Outside") {
    Row("Item")
}
.sectionTitlePosition(.outside)
```

## Separators and Borders

```swift
Layout("Library") {
    Section("Recent") {
        Row("Design")
        Row("Engineering")
    }
}
.sectionTitleSeparator(.visible)
.bordered()
```

## Background Style

``SectionBackgroundStyle`` switches between the standard surface and a dotted outline, which suits
"create new" affordances:

```swift
Section("New") {
    Button("Create a group") {}
}
.sectionBackgroundStyle(.dotted)
```

## Section Actions

Trailing buttons on the section header:

```swift
Section("Playlists") {
    Row("Favourites")
}
.sectionActions {
    Button("Add") {}
    Button("Edit") {}
}
```

## Sections in a List

``ListLayout`` uses ``ListSection``, which pairs with ``ListSectionHeader`` and
``ListSectionFooter``:

```swift
ListLayout("Settings") {
    ListSection("General") {
        ListRow("Appearance")
        ListRow("Language")
    }

    ListSection {
        ListRow("Storage")
    } header: {
        ListSectionHeader(title: "Advanced") {
            Button("Manage") {}
        }
    } footer: {
        ListSectionFooter(description: "Cached data can be removed at any time.")
    }
}
```

## Migration

`SectionView` is superseded by native `Section` inside a layout:

```swift
// Before
SectionView("Account Settings") {
    VStack(spacing: .small) {
        Row("Profile")
        Row("Privacy")
    }
}

// After
Layout {
    Section("Account Settings") {
        Row("Profile")
        Row("Privacy")
    }
}
```

## Topics

### Layouts

- ``Layout``
- ``ListLayout``

### List sections

- ``ListSection``
- ``ListSectionHeader``
- ``ListSectionFooter``

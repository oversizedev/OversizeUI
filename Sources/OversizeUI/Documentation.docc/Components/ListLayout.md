# ListLayout

A `List`-backed screen with optional multi-selection.

## Overview

``ListLayout`` renders its content in a native `List`, which brings swipe actions, edit mode and
selection for free. Use it when the screen is a genuine list of rows; use ``Layout`` when the
screen mixes sections of arbitrary content.

> Availability: iOS 18, macOS 15, tvOS 18, watchOS 11 and visionOS 2.

## Basic Usage

```swift
NavigationStack {
    ListLayout("Playlist") {
        ListSection("Tracks") {
            ForEach(tracks) { track in
                ListRow(track.title, subtitle: track.artist)
            }
        }
    }
    .listLayoutStyle(.insetGrouped)
}
```

## Sections

``ListSection`` pairs with ``ListSectionHeader`` and ``ListSectionFooter``:

```swift
ListLayout("Settings") {
    ListSection("General") {
        ListRow("Appearance")
        ListRow("Language")
    }

    ListSection {
        ListRow("Background refresh")
    } footer: {
        ListSectionFooter(description: "Uses cellular data when Wi-Fi is unavailable.")
    }

    ListSection {
        ListRow("Storage")
    } header: {
        ListSectionHeader(title: "Advanced") {
            Button("Manage") {}
        }
    }
}
```

## Selection

Pass a selection binding to enable multi-selection. Not available on watchOS.

```swift
@State private var selection: Set<Track.ID>?

ListLayout("Tracks", selection: $selection) {
    ListSection {
        ForEach(tracks) { track in
            ListRow(track.title)
        }
    }
}
```

## Rows

``ListRow`` is the list-friendly counterpart to ``Row``. Its leading content is an `Image`:

```swift
ListRow("Calendar", subtitle: "Sync your events", leading: {
    Image.Base.calendar.icon()
}, trailing: {
    Toggle("", isOn: $isOn)
        .labelsHidden()
})
```

``ListButton`` renders an action row:

```swift
ListButton("Sign out") { signOut() }
```

## Topics

### Related layouts

- ``Layout``
- ``ListCoverLayout``

### Rows and sections

- ``ListRow``
- ``ListButton``
- ``ListSection``
- ``ListSectionHeader``
- ``ListSectionFooter``

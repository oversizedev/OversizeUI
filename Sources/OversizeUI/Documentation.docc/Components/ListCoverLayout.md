# ListCoverLayout

A `List` beneath a stretchy cover.

## Overview

``ListCoverLayout`` is ``CoverLayout`` for list-shaped screens: the cover behaves the same way,
but the content is a native `List`, so rows get swipe actions, edit mode and selection.

> Availability: iOS 18, macOS 15, tvOS 18, watchOS 11 and visionOS 2.

## Basic Usage

```swift
NavigationStack {
    ListCoverLayout("Playlist") {
        ListSection("Tracks") {
            ForEach(tracks) { track in
                ListRow(track.title, subtitle: track.artist)
            }
        }
    } cover: {
        Image("playlist-art")
            .resizable()
            .scaledToFill()
    }
}
```

## Selection

Not available on watchOS.

```swift
@State private var selection: Set<Track.ID>?

ListCoverLayout("Playlist", selection: $selection) {
    ListSection {
        ForEach(tracks) { track in
            ListRow(track.title)
        }
    }
} cover: {
    Image("playlist-art")
        .resizable()
        .scaledToFill()
}
```

## Topics

### Related layouts

- ``CoverLayout``
- ``ListLayout``

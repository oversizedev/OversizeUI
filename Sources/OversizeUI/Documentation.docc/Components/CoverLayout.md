# CoverLayout

Sectioned content beneath a stretchy cover image.

## Overview

``CoverLayout`` puts a cover — an image, a gradient, any view — above content built from native
`Section`s. The cover stretches on overscroll and collapses as the user scrolls down.

> Availability: iOS 18, macOS 15, tvOS 18, watchOS 11 and visionOS 2.

## Basic Usage

```swift
NavigationStack {
    CoverLayout("Album") {
        Section("Tracks") {
            ForEach(tracks) { track in
                Row(track.title)
            }
        }
    } cover: {
        Image("album-art")
            .resizable()
            .scaledToFill()
    }
}
```

## Cover Height

```swift
CoverLayout("Album", coverHeight: 420) {
    Section("Tracks") { ... }
} cover: {
    Image("album-art")
        .resizable()
        .scaledToFill()
}
```

## Backgrounds

Three separate backgrounds can be supplied: one behind the cover, one behind the content, and one
behind the whole screen.

```swift
CoverLayout("Album") {
    Section("Tracks") { ... }
} cover: {
    Image("album-art")
        .resizable()
        .scaledToFill()
} contentBackground: {
    Color.backgroundPrimary
} coverBackground: {
    Color.backgroundSecondary
}
```

## Scroll Tracking

```swift
CoverLayout("Album", onScroll: { _, headerVisibleRatio in
    isNavigationTitleVisible = headerVisibleRatio < 0.2
}) {
    Section("Tracks") { ... }
} cover: {
    Image("album-art")
        .resizable()
        .scaledToFill()
}
```

## Topics

### Related layouts

- ``Layout``
- ``ListCoverLayout``

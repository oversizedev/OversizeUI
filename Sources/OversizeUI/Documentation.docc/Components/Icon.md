# Icon

A themed icon that renders either a bundled asset or an SF Symbol.

## Overview

``Icon`` is a small wrapper that applies the design system's icon colour and size. It takes either
an `Image` — typically one from the bundled `Image.Base` catalogue — or an SF Symbol name.

## Basic Usage

```swift
// Bundled icon
Icon(Image.Base.setting)

// SF Symbol
Icon("bolt.fill")
```

## The Icon Catalogue

Bundled icons live under the `Image.Base` namespace, generated from the asset catalogue by
SwiftGen. Names are camel-cased asset names:

```swift
Icon(Image.Base.heart)
Icon(Image.Base.search)
Icon(Image.Base.chevronRight)
Icon(Image.Base.notification)
```

Many icons ship variants, nested under a type of the same name:

```swift
Icon(Image.Base.Heart.fill)
Icon(Image.Base.Eye.slash)
Icon(Image.Base.ArrowDown.square)
Icon(Image.Base.Activity.TwoTone.fill)
```

Browse the full set in the **Icons** screen of the example app, or in
`Sources/OversizeUI/Core/Icons.swift`.

## Size

``IconSizes`` has five steps: `.xSmall`, `.small`, `.medium` (the default), `.large` and `.xLarge`.

```swift
Icon(Image.Base.star)
    .iconSize(.xSmall)

Icon(Image.Base.star)
    .iconSize(.large)

// Arbitrary size
Icon(Image.Base.star)
    .iconSize(custom: 18)
```

## Colour

Icons default to `Color.onSurfacePrimary` and follow the environment:

```swift
Icon(Image.Base.check)
    .iconColor(.success)

Icon(Image.Base.delete)
    .iconColor(.error)
```

## In Other Components

Most components that take leading or trailing content accept an ``Icon``:

```swift
Row("Notifications", subtitle: "Manage your alerts", leading: {
    Icon(Image.Base.notification)
})

Button {
    refresh()
} label: {
    Icon(Image.Base.swap)
}
.buttonStyle(.tertiary)
```

``ListRow`` is the exception — its leading content is an `Image`, so use the `icon()` helper:

```swift
ListRow("Calendar", leading: {
    Image.Base.calendar.icon()
})
```

## Migration

`IconDeprecated` and the `IconsNames` enum are deprecated. Replace name-based lookups with the
`Image.Base` catalogue:

```swift
// Before
IconDeprecated(.settings)

// After
Icon(Image.Base.setting)
```

## Topics

### Modifiers

- ``SwiftUI/View/iconSize(_:)``
- ``SwiftUI/View/iconColor(_:)``

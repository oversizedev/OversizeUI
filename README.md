# OversizeUI

[![Build Example](https://github.com/oversizedev/OversizeUI/actions/workflows/build-example.yml/badge.svg)](https://github.com/oversizedev/OversizeUI/actions/workflows/build-example.yml) [![Deploy DocC](https://github.com/oversizedev/OversizeUI/actions/workflows/publish-docc.yml/badge.svg)](https://github.com/oversizedev/OversizeUI/actions/workflows/publish-docc.yml)

Yet another component library on SwiftUI

## Design System
Controls and styles in [Figma](https://www.figma.com/community/file/1144847542164788208)

## Controls

Some of the controls available include:
- Avatar
- Background
- BlurView
- Button
- ColorSelector
- GridSelect
- HUD
- Icon
- Loader
- Row
- SectionView
- SegmentedControl
- Select
- Surface
- TextField
and more in: [OversizeUI](Sources/OversizeUI).

## Core

Colors, Typography, Spacing and other styles in [core folder](Sources/OversizeUI/Core)

## Getting Started
### Install and use OversizeUI

#### Requirements
- iOS 15+ or macOS 12.0+
- Xcode 14.2+
- Swift 5.7+

#### Swift Package Manager
- File > Swift Packages > Add Package Dependency
- Add `https://github.com/oversizedev/OversizeUI.git`
- Select "Up to Next Major" with "3.0.3"

### Import and use OversizeUI
After the framework has been added you can import the module to use it:

```swift
import OversizeUI
```

## Example app

To build and deploy the demo follow these steps:
- Open `Example/Example.xcodeproj` in Xcode.
- In the Xcode scheme menu choose `Example (iOS)` or other and choose a device to deploy to.
- Once deployed you can choose a control to demo from the list of controls on the selected device.

## Examples components

### Avatars
```swift
Avatar(firstName: "Swift", lastName: "Apple")
    .controlSize(.large)
```

### Buttons
```swift
Button("Button") { print(#function) }
    .buttonStyle(.primary)
    .accent()
    .controlBorderShape(.capsule)
    .bordered()
```

### Color selector
```swift
ColorSelector(selection: $color)
```

```swift
ColorSelector(selection: $color)
    .colorSelectorStyle(GridColorSelectorStyle())
```

### GridSelect
```swift
var items = ["One", "Two", "Three", "Four"]
@State var selection = ""
GridSelect(items, selection: $selection,
           content: { item, _ in
               VStack {
                   Icon(.circle)
                   Text(item)
               }.padding()
           })

```

### Icon
```swift
Icon(.activity)

```

### Row
```swift
Row("Title")

```

### SegmentedPickerSelector
```swift
SegmentedPickerSelector(items, selection: $selection) { item, _ in
    Text(item)
}
```

### Select
```swift
Select("Select", items, selection: $selection) { item, _ in
    Text(item)
} selectionView: { selected in
    Text(selected)
}
```

### Surface
```swift
Surface(background: .secondary) {
    Text("Text")
}
```

### TextField
```swift
TextField("Text", text: $placeholder))
    .textFieldStyle(.default)
}
```


#### Swift Lint
This project uses [SwiftLint](https://github.com/realm/SwiftLint) to automatically lint our Swift code for common errors. Please install it when developing in this repo by following the [SwiftLint Installation Instructions](https://realm.github.io/SwiftLint/).


### License

OversizeUI is released under the MIT license. See LICENSE for details.

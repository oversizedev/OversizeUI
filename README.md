# OversizeUI

[![Swift](https://img.shields.io/badge/Swift-6.1+-orange.svg)](https://swift.org)
[![Build Example](https://github.com/oversizedev/OversizeUI/actions/workflows/ci.yml/badge.svg)](https://github.com/oversizedev/OversizeUI/actions/workflows/ci.yml)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/oversizedev/OversizeUI/blob/main/LICENSE)

### SwiftUI Component Library

OversizeUI is a SwiftUI component library that provides a comprehensive set of customizable UI components following modern design principles. Built with theming and developer experience in mind, OversizeUI accelerates development while maintaining design consistency across your applications.

### Design System Core

**Colors**: Semantic color system with light/dark mode support
**Typography**: Scalable type system with Dynamic Type support
**Spacing**: Consistent spacing scale from `.xxxSmall` to `.xxxLarge`
**Elevation**: Shadow system with five levels, `.z0` through `.z4`
**Radius**: Configurable corner radius system
**Themes**: Built-in themes with custom theme support

All components in: [Sources/OversizeUI](Sources/OversizeUI)
Core design tokens in: [Sources/OversizeUI/Core](Sources/OversizeUI/Core)
API documentation: [Sources/OversizeUI/Documentation.docc](Sources/OversizeUI/Documentation.docc)

## Getting Started

### Requirements

- **iOS**: 15.0+
- **macOS**: 13.0+
- **tvOS**: 15.0+
- **watchOS**: 9.0+
- **visionOS**: 2.0+
- **Xcode**: 16.3+
- **Swift**: 6.1+

The [layout system](#layouts) requires iOS 18, macOS 15, tvOS 18, watchOS 11 or visionOS 2. Everything else runs on the deployment targets above.

### Installation

#### Swift Package Manager

1. In Xcode, go to **File → Add Package Dependencies**
2. Enter the repository URL:
   ```
   https://github.com/oversizedev/OversizeUI.git
   ```
3. Choose **"Up to Next Major"** with version **"3.19.0"**
4. Click **Add Package**

Or add it to a `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/oversizedev/OversizeUI.git", .upToNextMajor(from: "3.19.0")),
]
```

### Quick Start

```swift
import SwiftUI
import OversizeUI

struct ContentView: View {
    @State private var name = ""
    @State private var helper = "We use this to greet you"
    @State private var helperStyle: FieldHelperStyle = .helperText

    var body: some View {
        VStack(spacing: .medium) {
            TextField("Enter your name", text: $name)
                .textFieldStyle(.default)
                .fieldHelper($helper, style: $helperStyle)

            Button("Get Started") {
                guard name.isEmpty == false else {
                    helper = "Name is required"
                    helperStyle = .errorText
                    return
                }
                print("Welcome, \(name)!")
            }
            .buttonStyle(.primary)
            .controlSize(.large)
            .accent()
        }
        .padding()
        .surface()
    }
}
```

Apply a theme once, at the root of your app:

```swift
@main
struct MyApp: App {
    @Environment(\.theme) private var theme

    var body: some Scene {
        WindowGroup {
            ContentView()
                .theme(ThemeSettings())
                .preferredColorScheme(theme.appearance.colorScheme)
        }
    }
}
```

## Layouts

The layout system is the recommended way to build screens. `Layout` takes native SwiftUI `Section`s and renders them with the design system's spacing, borders and backgrounds.

```swift
NavigationStack {
    Layout("Settings") {
        Section("Account") {
            Row("Profile")
            Row("Privacy")
        }

        Section {
            Row("Notifications")
        } header: {
            Text("Alerts")
        } footer: {
            Text("Turning this off stops background refresh.")
        }

        Section("New") {
            Button("Create a group") {}
        }
        .sectionBackgroundStyle(.dotted)
    }
    .listLayoutStyle(.insetGrouped)
    .sectionTitlePosition(.inside)
    .sectionTitleSeparator(.visible)
    .bordered()
}
```

### Section modifiers

| Modifier | Values |
|---|---|
| `.listLayoutStyle(_:)` | `.plain`, `.inset`, `.insetGrouped`, `.smallInsetGrouped`, `.grouped` |
| `.sectionTitlePosition(_:)` | `.inside`, `.outside` |
| `.sectionTitleSeparator(_:)` | `.visible`, `.hidden` |
| `.sectionBackgroundStyle(_:)` | `.surface`, `.dotted`, `.plain` |
| `.sectionActions { }` | Trailing buttons on a section header |
| `.bordered(_:)` | Toggles section borders |

### Layout variants

| View | Use for |
|---|---|
| `Layout` | Scrolling screens built from `Section`s |
| `ListLayout` | `List`-backed screens, with optional multi-selection |
| `CoverLayout` | A stretchy cover image above sectioned content |
| `ListCoverLayout` | A stretchy cover above a `List` |
| `CalendarLayout` | A month calendar above sectioned content (iOS only) |

```swift
ListLayout("Playlist") {
    ListSection("Tracks") {
        ForEach(tracks) { track in
            ListRow(track.title, subtitle: track.artist)
        }
    }
}
.listLayoutStyle(.insetGrouped)
```

```swift
CoverLayout("Album", coverHeight: 300) {
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
```

## Component Examples

### Avatars

```swift
// Initials
Avatar(firstName: "John", lastName: "Doe")
    .controlSize(.large)

// Custom image
Avatar(avatar: Image("profile-photo"))
    .avatarStroke(.accent, lineWidth: 2)
    .controlSize(.regular)

// Gradient background
Avatar(firstName: "AI", lastName: "Bot")
    .avatarBackground(.gradient([.blue, .purple]))
    .avatarOnBackground(.white)
    .controlSize(.small)
```

### Buttons

```swift
Button("Save Changes") { save() }
    .buttonStyle(.primary)
    .controlSize(.large)
    .accent()

Button("Cancel") { dismiss() }
    .buttonStyle(.secondary)
    .bordered()

Button {
    refresh()
} label: {
    Icon(Image.Base.arrowDown)
}
.buttonStyle(.tertiary)
.controlBorderShape(.capsule)
```

### Icons

`Icon` takes either a bundled `Image.Base` icon or an SF Symbol name.

```swift
Icon(Image.Base.setting)
    .iconSize(.small)
    .iconColor(.accent)

Icon(Image.Base.Eye.slash)

Icon("bolt.fill")
```

### Color Selector

Not available on watchOS and tvOS.

```swift
@State private var selectedColor = Color.blue

ColorSelector(selection: $selectedColor)
    .colorSelectorStyle(HorizontalColorSelectorStyle())

ColorSelector(selection: $selectedColor)
    .colorSelectorStyle(GridColorSelectorStyle())
```

### GridSelect

`GridSelect` is single-selection. For multiple selection use `MultiSelect`.

```swift
@State private var selected = "Swift"
let options = ["Swift", "SwiftUI", "Xcode", "iOS"]

GridSelect(options, selection: $selected) { item, isSelected in
    VStack {
        Icon(Image.Base.category)
        Text(item)
            .caption()
    }
    .padding()
}
.gridSelectStyle(SelectionOnlyGridSelectStyle())
```

### TextField

`fieldHelper` takes bindings, so the helper text and its style can change with validation. `FieldHelperStyle` is `.none`, `.helperText`, `.errorText` or `.sussesText`.

```swift
@State private var email = ""
@State private var helper = "Enter a valid email"
@State private var helperStyle: FieldHelperStyle = .helperText

TextField("Email", text: $email)
    .textFieldStyle(.default)
    .fieldLabelPosition(.overInput)
    .fieldHelper($helper, style: $helperStyle)
```

### Row

```swift
@State private var isDarkMode = false

Row("Settings")

Row("Notifications", subtitle: "Manage your alerts", leading: {
    Icon(Image.Base.notification)
})

Row("Dark Mode", leading: {
    Icon(Image.Base.eye)
}, trailing: {
    Toggle("", isOn: $isDarkMode)
        .labelsHidden()
})

Row("Account", subtitle: "Profile and privacy") { openAccount() }
    .navigatable()
```

`ListRow` is the `List`-friendly counterpart, and takes an `Image` as its leading content:

```swift
ListRow("Calendar", subtitle: "Sync your events", leading: {
    Image.Base.calendar.icon()
})
```

### SegmentedControl

```swift
@State private var selectedView = "List"
let options = ["List", "Grid", "Card"]

SegmentedPickerSelector(options, selection: $selectedView) { option, _ in
    Text(option)
}
.segmentedControlStyle(IslandSegmentedControlStyle())
```

Other styles: `SelectionOnlySegmentedControlStyle()`, `ScrollSegmentedControlStyle()`, `.onlySelection(selected:)`, `.islandScroll(selected:)`.

### Select

Requires iOS 17, macOS 14, tvOS 17 or watchOS 10.

```swift
@State private var country = "United States"
let countries = ["United States", "Canada", "United Kingdom"]

Select("Choose Country", countries, selection: $country) { country, isSelected in
    Radio(country, isOn: isSelected)
} selectionView: { selected in
    Text(selected)
}
```

### Surface

```swift
Surface {
    VStack(alignment: .leading, spacing: .xxSmall) {
        Text("Welcome").title3()
        Text("Get started with OversizeUI").body()
    }
}
.surfaceStyle(.secondary)
.elevation(.z2)

// As a modifier
Text("Elevated")
    .surface()
    .elevation(.z4)
```

## Component Catalogue

| Area | Components |
|---|---|
| Layouts | `Layout`, `ListLayout`, `CoverLayout`, `ListCoverLayout`, `CalendarLayout` (iOS), `ListSection`, `ListSectionHeader`, `ListSectionFooter` |
| Buttons | `.primary`, `.secondary`, `.tertiary`, `.quaternary`, `.row`, `.field`, `.scale`, `DottedButtonStyle`, `IconButtonStyle` |
| Rows | `Row`, `ListRow`, `ListButton`, `RowButton`, `RowTitle` |
| Selection | `GridSelect`, `MultiSelect`, `Select`, `SegmentedPickerSelector`, `ColorSelector` (not watchOS/tvOS), `RadioPicker` |
| Toggles | `Checkbox`, `Radio`, `Switch` |
| Fields | `TextField` styles, `TextBox`, `DateField` (iOS 17+), `PhoneField` (iOS), `PriceField`, `URLField`, `KeyboardToolbar` |
| Feedback | `NoticeView`, `HUD`, `Snackbar`, `LoaderOverlayView`, `ContentView` |
| Status | `EmptyStateView`, `ErrorView`, `SuccessView` (iOS 17+) |
| Containers | `Surface`, `MaterialSurface` (iOS), `Background`, `Separator` |
| Media | `Icon`, `CachedAsyncImage`, `Avatar`, `Badge`, `PremiumLabel`, `PageIndexView` |
| Scrolling | `ScrollViewWithOffsetTracking`, `ScrollViewHeader` |
| Stacks | `LeadingVStack`, `CenterVStack`, `TrailingVStack` and their lazy variants |
| Shapes | `AnyShape`, `RoundedRectangleCorner`, `ScrollArrow` |

## Migration

The old page and navigation stack is deprecated in favour of native SwiftUI navigation and the layout system.

| Deprecated | Replacement |
|---|---|
| `PageView`, `LayoutView` | `Layout` |
| `CoverLayoutView` | `CoverLayout` |
| `ListLayoutView` | `ListLayout` |
| `ListCoverLayoutView` | `ListCoverLayout` |
| `CalendarLayoutView` | `CalendarLayout` |
| `SectionView` | `Section` inside `Layout` |
| `BarButton`, `ModalNavigationBar`, `.leadingBar`, `.scrollWithNavigationBar` | `NavigationStack` + `.navigationTitle` + `.toolbar` |
| `IconDeprecated`, `IconsNames` | `Icon(Image.Base.…)` |
| `ScrollViewOffset` | `ScrollViewWithOffsetTracking` |
| `.rowArrow()` | `.navigatable()` |
| `.shadow(elevation:)` | `.shadowElevation(_:)` |
| `.screenSize` safe-area accessors | `@Environment(\.safeAreaInsets)` |

## Example App

The example app is a gallery of every component, built on the layout system.

1. Clone the repository:
   ```bash
   git clone https://github.com/oversizedev/OversizeUI.git
   cd OversizeUI
   ```

2. Open the example project:
   ```bash
   open Example/Example.xcodeproj
   ```

3. Pick a scheme — **Example (iOS)**, **Example (macOS)**, **Example (tvOS)** or **Example (watchOS)** — and run (`⌘R`).

Screens are registered in [`Example/Shared/Demos.swift`](Example/Shared/Demos.swift). Adding a demo there adds it to the gallery and makes it reachable from the UI tests.

## Testing

Package unit tests:

```bash
swift test
```

Example app UI tests (XCUITest, in [`Example/ExampleUITests`](Example/ExampleUITests)):

```bash
xcodebuild -project Example/Example.xcodeproj \
  -scheme "Example (iOS)" \
  -destination "platform=iOS Simulator,name=iPhone 17 Pro" \
  test -retry-tests-on-failure -test-iterations 3 \
  CODE_SIGNING_ALLOWED=NO
```

Each demo screen has a `<Component>Test` subclassing `BaseTest`, which launches the app and opens the screen by its title from `Demos.swift`. Interactive assertions hang off accessibility identifiers set in the demo pages.

## Resources

#### Design Resources
- [**Figma Design System**](https://www.figma.com/community/file/1144847542164788208) — complete design system

#### Development Tools
- [**SwiftLint Config**](.swiftlint.yml) — code quality and consistency
- [**SwiftFormat Config**](.swiftformat) — automatic code formatting
- [**SwiftGen Templates**](Templates/) — asset code generation templates

## License

OversizeUI is released under the **MIT License**. See [LICENSE](LICENSE) for details.

---

<div align="center">

**Made with ❤️ by the Oversize**

</div>

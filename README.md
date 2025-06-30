# OversizeUI

**SwiftUI Component Library**

[![Swift](https://img.shields.io/badge/Swift-6.0+-orange.svg)](https://swift.org)
[![Build Example](https://github.com/oversizedev/OversizeUI/actions/workflows/build-example.yml/badge.svg)](https://github.com/oversizedev/OversizeUI/actions/workflows/ci-release.yml)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/oversizedev/OversizeUI/blob/main/LICENSE)

OversizeUI is a powerful SwiftUI component library that provides a comprehensive set of customizable UI components following modern design principles. Built with theming, and developer experience in mind, OversizeUI accelerates development while maintaining design consistency across your applications.

### Design System Core

**Colors**: Semantic color system with light/dark mode support
**Typography**: Scalable type system with Dynamic Type support  
**Spacing**: Consistent spacing scale from .xxSmall to .xxLarge
**Elevation**: Material Design inspired shadow system
**Radius**: Configurable corner radius system
**Themes**: Multiple built-in themes with custom theme support

All components in: [Sources/OversizeUI](Sources/OversizeUI)*
Сore design tokens in: [Sources/OversizeUI/Core](Sources/OversizeUI/Core)*

## Getting Started

### Requirements

- **iOS**: 15.0+ 
- **macOS**: 13.0+
- **tvOS**: 15.0+
- **watchOS**: 9.0+
- **visionOS**: 2.0+
- **Xcode**: 16.4+
- **Swift**: 6.0+

### Installation

### Swift Package Manager

1. In Xcode, go to **File → Add Package Dependencies**
2. Enter the repository URL:
   ```
   https://github.com/oversizedev/OversizeUI.git
   ```
3. Choose **"Up to Next Major"** with version **"3.0.3"**
4. Click **Add Package**


### Quick Start

```swift
import SwiftUI
import OversizeUI

struct ContentView: View {
    @State private var name = ""
    @State private var selectedColor = Color.blue
    
    var body: some View {
        VStack(spacing: .medium) {
            // Enhanced TextField with validation
            TextField("Enter your name", text: $name)
                .textFieldStyle(.default)
                .fieldHelper("This field is required", style: .constant(.error))
            
            // Color Selector
            ColorSelector(selection: $selectedColor)
                .colorSelectorStyle(.grid)
            
            // Primary Button
            Button("Get Started") {
                print("Welcome, \(name)!")
            }
            .buttonStyle(.primary)
            .controlSize(.large)
            .accent()
        }
        .padding()
        .surface() // Apply surface styling
    }
}
```

## Example App

Experience OversizeUI in action with our comprehensive example app that showcases all components and their variations.

### Running the Example

1. Clone the repository:
   ```bash
   git clone https://github.com/oversizedev/OversizeUI.git
   cd OversizeUI
   ```

2. Open the example project:
   ```bash
   open Example/Example.xcodeproj
   ```

3. Select your target platform:
   - **Example (iOS)** - iPhone and iPad support
   - **Example (macOS)** - Native macOS experience
   - **Example (tvOS)** - Apple TV interface
   - **Example (watchOS)** - Apple Watch optimized

4. Build and run (`⌘+R`) to explore the interactive component gallery

## Component Examples

### Avatars

Perfect for user profiles, team members, and contact lists.

```swift
// Simple avatar with initials
Avatar(firstName: "John", lastName: "Doe")
    .controlSize(.large)

// Avatar with custom image
Avatar(avatar: Image("profile-photo"))
    .controlSize(.medium)
    .stroke(Color.accent, lineWidth: 2)

// Avatar with custom background
Avatar(firstName: "AI", lastName: "Bot")
    .avatarBackground(.gradient([.blue, .purple]))
    .controlSize(.small)
```

### Buttons

Comprehensive button system with multiple styles and states.

```swift
// Primary action button
Button("Save Changes") { saveData() }
    .buttonStyle(.primary)
    .controlSize(.large)
    .accent()

// Secondary button with icon
Button("Cancel") { dismiss() }
    .buttonStyle(.secondary)
    .bordered()

// Icon-only button
Button(action: refresh) {
    Icon(.refresh)
}
.buttonStyle(.tertiary)
.controlBorderShape(.circle)
```

### Color Selector

Color picker with multiple display modes.

```swift
@State private var selectedColor = Color.blue

// Grid-style color picker
ColorSelector(selection: $selectedColor)
    .colorSelectorStyle(.grid)

// Palette-style color picker
ColorSelector(selection: $selectedColor)
    .colorSelectorStyle(.palette)
    .controlSize(.large)
```

### GridSelect

Flexible multi-selection grid for various content types.

```swift
@State private var selectedItems: Set<String> = []
let options = ["Swift", "SwiftUI", "Xcode", "iOS"]

GridSelect(options, selection: $selectedItems) { item, isSelected in
    VStack {
        Icon(.swift)
            .foregroundColor(isSelected ? .white : .primary)
        Text(item)
            .font(.caption)
    }
    .padding()
    .background(isSelected ? Color.accent : Color.surface)
    .cornerRadius(.medium)
}
```

### TextField

Enhanced text input with validation and styling options.

```swift
@State private var email = ""
@State private var password = ""

VStack {
    // Email field with validation
    TextField("Email", text: $email)
        .textFieldStyle(.default)
        .keyboardType(.emailAddress)
        .fieldHelper("Enter a valid email", style: .constant(.info))
    
    // Secure password field
    SecureField("Password", text: $password)
        .textFieldStyle(.default)
        .fieldHelper("Minimum 8 characters", style: .constant(.warning))
}
```

### Row

Perfect for lists, menus, and navigation interfaces.

```swift
VStack {
    // Simple row
    Row("Settings")
    
    // Row with subtitle and icon
    Row("Notifications", subtitle: "Manage your alerts") {
        Icon(.bell)
    }
    
    // Interactive row with trailing content
    Row("Dark Mode") {
        Toggle("", isOn: $isDarkMode)
    }
}
```

### SegmentedControl

Segmented control with island-style design.

```swift
@State private var selectedView = "List"
let options = ["List", "Grid", "Card"]

SegmentedPickerSelector(options, selection: $selectedView) { option, _ in
    Text(option)
}
.segmentedControlStyle(.island)
```

### Select

Dropdown selector with search and custom content support.

```swift
@State private var selectedCountry = ""
let countries = ["United States", "Canada", "United Kingdom"]

Select("Choose Country", countries, selection: $selectedCountry) { country, _ in
    HStack {
        // Country flag
        Text(countryFlag(for: country))
        Text(country)
    }
} selectionView: { selected in
    Text(selected.isEmpty ? "Select Country" : selected)
}
```

### Surface

Flexible container with elevation and styling.

```swift
Surface {
    VStack {
        Text("Welcome")
            .font(.title)
        Text("Get started with OversizeUI")
            .font(.body)
    }
    .padding()
}
.elevation(.medium)
.background(.secondary)
```

## Resources

#### Design Resources
- [**Figma Design System**](https://www.figma.com/community/file/1144847542164788208) - Complete design system

#### Development Tools
- [**SwiftLint Config**](.swiftlint.yml) - Code quality and consistency
- [**SwiftFormat Config**](.swiftformat) - Automatic code formatting
- [**XcodeGen Templates**](Templates/) - Component creation templates

## License

OversizeUI is released under the **MIT License**. See [LICENSE](LICENSE) for details.

---

<div align="center">

**Made with ❤️ by the Oversize**

</div>

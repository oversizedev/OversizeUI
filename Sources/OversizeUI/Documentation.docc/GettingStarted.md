# Getting Started

Learn how to integrate OversizeUI into your SwiftUI project and create your first interface.

## Overview

OversizeUI is designed to make SwiftUI development faster and more consistent. This guide will walk you through installation, basic setup, and creating your first interface with OversizeUI components.

## Installation

### Requirements

- **iOS**: 15.0+
- **macOS**: 12.0+
- **tvOS**: 15.0+
- **watchOS**: 9.0+
- **visionOS**: 2.0+
- **Xcode**: 14.2+
- **Swift**: 5.7+

### Swift Package Manager

1. In Xcode, go to **File → Add Package Dependencies**
2. Enter the repository URL:
   ```
   https://github.com/oversizedev/OversizeUI.git
   ```
3. Choose **"Up to Next Major"** with version **"3.0.3"**
4. Click **Add Package**

### Manual Installation

1. Download or clone the repository
2. Drag `OversizeUI.xcodeproj` into your Xcode project
3. Add OversizeUI as a dependency to your target

## Basic Setup

### Import the Framework

```swift
import SwiftUI
import OversizeUI
```

### Configure Theming

Enable theming support in your app by adding the `ThemeSettings` environment object:

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ThemeSettings())
        }
    }
}
```

## Your First Interface

Let's build a simple profile form using OversizeUI components:

```swift
import SwiftUI
import OversizeUI

struct ProfileFormView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var favoriteColor = Color.blue
    @State private var selectedTheme = "Default"
    
    private let themes = ["Default", "Blue", "Green", "Purple"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: .large) {
                // Header with Avatar
                profileHeader
                
                // Form Section
                formSection
                
                // Settings Section
                settingsSection
                
                // Action Buttons
                actionButtons
            }
            .padding()
        }
        .navigationTitle("Profile")
    }
    
    private var profileHeader: some View {
        VStack(spacing: .medium) {
            Avatar(firstName: firstName, lastName: lastName)
                .controlSize(.large)
                .stroke(.accent, lineWidth: 2)
            
            Text(fullName)
                .title2(.bold)
                .foregroundColor(.onSurfacePrimary)
        }
    }
    
    private var formSection: some View {
        SectionView("Personal Information") {
            VStack(spacing: .medium) {
                TextField("First Name", text: $firstName)
                    .textFieldStyle(.default)
                
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(.default)
                
                TextField("Email", text: $email)
                    .textFieldStyle(.default)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }
        }
    }
    
    private var settingsSection: some View {
        SectionView("Preferences") {
            VStack(spacing: .medium) {
                // Color Selector
                VStack(alignment: .leading, spacing: .small) {
                    Text("Favorite Color")
                        .headline()
                        .foregroundColor(.onSurfacePrimary)
                    
                    ColorSelector(selection: $favoriteColor)
                        .colorSelectorStyle(.grid)
                }
                
                // Theme Selector
                VStack(alignment: .leading, spacing: .small) {
                    Text("Theme")
                        .headline()
                        .foregroundColor(.onSurfacePrimary)
                    
                    Select("Choose Theme", themes, selection: $selectedTheme) { theme, _ in
                        Text(theme)
                    } selectionView: { selected in
                        Text(selected.isEmpty ? "Choose Theme" : selected)
                    }
                }
            }
        }
    }
    
    private var actionButtons: some View {
        VStack(spacing: .medium) {
            Button("Save Profile") {
                saveProfile()
            }
            .buttonStyle(.primary)
            .controlSize(.large)
            .accent()
            
            Button("Reset") {
                resetForm()
            }
            .buttonStyle(.secondary)
            .controlSize(.large)
        }
    }
    
    private var fullName: String {
        [firstName, lastName]
            .filter { !$0.isEmpty }
            .joined(separator: " ")
            .isEmpty ? "Your Name" : [firstName, lastName].joined(separator: " ")
    }
    
    private func saveProfile() {
        // Save profile logic
        print("Saving profile: \(fullName)")
    }
    
    private func resetForm() {
        firstName = ""
        lastName = ""
        email = ""
        favoriteColor = .blue
        selectedTheme = "Default"
    }
}
```

## Understanding the Components

### Surface and Sections

The `SectionView` component creates grouped content areas with proper spacing and styling:

```swift
SectionView("Section Title") {
    // Your content here
}
```

### Form Controls

OversizeUI provides enhanced form controls with consistent styling:

```swift
// Enhanced TextField
TextField("Placeholder", text: $text)
    .textFieldStyle(.default)

// Color Picker
ColorSelector(selection: $color)
    .colorSelectorStyle(.grid)

// Dropdown Selector
Select("Title", options, selection: $selection) { option, _ in
    Text(option)
} selectionView: { selected in
    Text(selected ?? "Select...")
}
```

### Buttons and Actions

Use semantic button styles for different action types:

```swift
// Primary action
Button("Save") { save() }
    .buttonStyle(.primary)
    .controlSize(.large)

// Secondary action
Button("Cancel") { cancel() }
    .buttonStyle(.secondary)

// Tertiary action
Button("More") { showMore() }
    .buttonStyle(.tertiary)
```

## Design System Integration

### Using Spacing Tokens

OversizeUI provides a consistent spacing system:

```swift
VStack(spacing: .medium) { // Uses design system spacing
    // Content
}
.padding(.large) // Consistent padding
```

### Typography System

Apply consistent typography using the built-in system:

```swift
Text("Title")
    .title2(.bold)

Text("Subtitle")
    .headline()

Text("Body text")
    .body()
```

### Color System

Use semantic colors that adapt to dark mode:

```swift
Text("Content")
    .foregroundColor(.onSurfacePrimary) // High contrast text

Surface {
    // Content
}
.background(.surfaceSecondary) // Adaptive background
```

## Next Steps

Now that you have a basic understanding of OversizeUI, explore these topics:

- **<doc:Architecture>**: Learn about the library's architecture and design principles
- **<doc:Theming>**: Customize the appearance to match your brand
- **<doc:Accessibility>**: Ensure your app is accessible to all users
- **<doc:BestPractices>**: Follow best practices for optimal performance and user experience

## See Also

- ``Avatar``
- ``Button``
- ``TextField``
- ``ColorSelector``
- ``Select``
- ``SectionView``
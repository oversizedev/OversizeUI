# Button

Trigger actions with various button styles optimized for different use cases.

## Overview

The `Button` component in OversizeUI provides a comprehensive button system with multiple styles, sizes, and states. Built on top of SwiftUI's native Button, it adds consistent styling, accessibility features, and loading states while maintaining the familiar SwiftUI API.

### Button Styles

OversizeUI provides four semantic button styles:

- **Primary**: Main call-to-action buttons
- **Secondary**: Secondary actions and alternatives
- **Tertiary**: Subtle actions and supplementary options
- **Quaternary**: Minimal actions with low visual weight

## Basic Usage

### Primary Button

Use primary buttons for the main action on a screen:

```swift
Button("Get Started") {
    startOnboarding()
}
.buttonStyle(.primary)
.controlSize(.large)
```

### Secondary Button

Use secondary buttons for important but not primary actions:

```swift
Button("Learn More") {
    showDetails()
}
.buttonStyle(.secondary)
.controlSize(.medium)
```

### Tertiary Button

Use tertiary buttons for supplementary actions:

```swift
Button("Cancel") {
    dismiss()
}
.buttonStyle(.tertiary)
```

### Quaternary Button

Use quaternary buttons for minimal actions:

```swift
Button("Skip") {
    skipStep()
}
.buttonStyle(.quaternary)
```

## Button Variations

### Icon Buttons

Create buttons with only icons:

```swift
Button(action: refresh) {
    Icon(.refresh)
}
.buttonStyle(.tertiary)
.controlBorderShape(.circle)
.accessibilityLabel("Refresh")
```

### Buttons with Icons

Combine text and icons for enhanced usability:

```swift
Button {
    addItem()
} label: {
    HStack {
        Icon(.plus)
        Text("Add Item")
    }
}
.buttonStyle(.primary)
```

### Loading State

Show loading states during asynchronous operations:

```swift
struct AsyncButton: View {
    @State private var isLoading = false
    
    var body: some View {
        Button("Save Changes") {
            performSave()
        }
        .buttonStyle(.primary)
        .loading(isLoading)
        .disabled(isLoading)
    }
    
    private func performSave() {
        isLoading = true
        
        Task {
            try await saveData()
            isLoading = false
        }
    }
}
```

## Control Sizes

Buttons support different sizes for various contexts:

```swift
// Mini size - for compact interfaces
Button("Mini") { }
    .buttonStyle(.primary)
    .controlSize(.mini)

// Small size - for secondary actions
Button("Small") { }
    .buttonStyle(.secondary)
    .controlSize(.small)

// Regular size - default
Button("Regular") { }
    .buttonStyle(.primary)

// Large size - for primary actions
Button("Large") { }
    .buttonStyle(.primary)
    .controlSize(.large)
```

## Customization

### Accent Colors

Apply accent colors to emphasize important actions:

```swift
Button("Save") {
    save()
}
.buttonStyle(.primary)
.accent() // Uses theme accent color

Button("Delete") {
    delete()
}
.buttonStyle(.primary)
.accent(.red) // Custom accent color
```

### Border Shapes

Customize button shapes:

```swift
// Capsule shape
Button("Rounded") { }
    .buttonStyle(.primary)
    .controlBorderShape(.capsule)

// Circle shape (for icon buttons)
Button {
    share()
} label: {
    Icon(.share)
}
.buttonStyle(.tertiary)
.controlBorderShape(.circle)

// Rounded rectangle (default)
Button("Standard") { }
    .buttonStyle(.primary)
    .controlBorderShape(.roundedRectangle)
```

### Bordered Buttons

Add borders for enhanced visual hierarchy:

```swift
Button("Outlined") {
    performAction()
}
.buttonStyle(.secondary)
.bordered()
```

### Infinity Width

Make buttons expand to fill available width:

```swift
Button("Full Width") {
    performAction()
}
.buttonStyle(.primary, infinityWidth: true)
```

## Advanced Examples

### Button Group

Create related button groups:

```swift
struct ButtonGroup: View {
    @State private var selectedAction: String?
    
    var body: some View {
        HStack(spacing: .medium) {
            Button("Save") {
                selectedAction = "save"
                save()
            }
            .buttonStyle(.primary)
            .loading(selectedAction == "save")
            
            Button("Save & Send") {
                selectedAction = "saveAndSend"
                saveAndSend()
            }
            .buttonStyle(.secondary)
            .loading(selectedAction == "saveAndSend")
            
            Button("Cancel") {
                cancel()
            }
            .buttonStyle(.tertiary)
        }
    }
}
```

### Floating Action Button

Create a floating action button:

```swift
struct FloatingActionButton: View {
    var body: some View {
        Button {
            createNew()
        } label: {
            Icon(.plus)
                .foregroundColor(.white)
        }
        .buttonStyle(.primary)
        .controlBorderShape(.circle)
        .controlSize(.large)
        .shadow(.large)
        .accessibilityLabel("Create new item")
    }
}
```

### Toolbar Buttons

Create buttons for toolbars and navigation:

```swift
struct ToolbarButtons: View {
    var body: some View {
        NavigationView {
            ContentView()
                .navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            dismiss()
                        }
                        .buttonStyle(.tertiary)
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showHelp()
                        } label: {
                            Icon(.questionmark)
                        }
                        .buttonStyle(.quaternary)
                        .accessibilityLabel("Help")
                    }
                }
        }
    }
}
```

### Destructive Actions

Handle destructive actions with appropriate styling:

```swift
struct DestructiveActionButton: View {
    @State private var showingDeleteAlert = false
    
    var body: some View {
        Button("Delete Account") {
            showingDeleteAlert = true
        }
        .buttonStyle(.primary)
        .accent(.red)
        .controlSize(.large)
        .alert("Delete Account", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                deleteAccount()
            }
        } message: {
            Text("This action cannot be undone. All your data will be permanently deleted.")
        }
    }
}
```

## Platform Adaptations

### iOS Specific Features

```swift
// Haptic feedback
Button("Tap Me") {
    performAction()
}
.buttonStyle(.primary)
.hapticFeedback(.impact(.medium), trigger: triggerHaptic)

// Context menus
Button("Options") {
    showMainAction()
}
.buttonStyle(.secondary)
.contextMenu {
    Button("Edit") { edit() }
    Button("Share") { share() }
    Button("Delete", role: .destructive) { delete() }
}
```

### macOS Specific Features

```swift
// Keyboard shortcuts
Button("Save") {
    save()
}
.buttonStyle(.primary)
.keyboardShortcut(.defaultAction) // Enter/Return

Button("Cancel") {
    cancel()
}
.buttonStyle(.tertiary)
.keyboardShortcut(.cancelAction) // Escape
```

## Accessibility

### Automatic Features

OversizeUI buttons automatically provide:

- **Focus Support**: Full keyboard navigation support
- **VoiceOver Labels**: Meaningful accessibility labels from button text
- **State Announcements**: Loading and disabled state announcements
- **Touch Target Size**: Minimum 44x44 point touch targets

### Custom Accessibility

Enhance accessibility for complex buttons:

```swift
Button {
    toggleFavorite()
} label: {
    Icon(isFavorite ? .heartFill : .heart)
}
.buttonStyle(.quaternary)
.accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")
.accessibilityHint("Double-tap to toggle favorite status")
.accessibilityValue(isFavorite ? "Favorited" : "Not favorited")
```

## Design Guidelines

### Do's

- ✅ Use primary buttons for the main action on a screen
- ✅ Limit to one primary button per screen section
- ✅ Use consistent button sizes within the same context
- ✅ Provide clear, action-oriented button labels
- ✅ Use loading states for asynchronous operations
- ✅ Group related buttons logically

### Don'ts

- ❌ Don't use multiple primary buttons in the same area
- ❌ Don't make buttons too small to tap comfortably (minimum 44x44 points)
- ❌ Don't rely solely on color to convey button state
- ❌ Don't use vague labels like "OK" or "Submit"
- ❌ Don't forget to handle disabled and loading states

## API Reference

### Button Styles

```swift
extension ButtonStyle {
    static var primary: OversizeButtonStyle
    static var secondary: OversizeButtonStyle
    static var tertiary: OversizeButtonStyle
    static var quaternary: OversizeButtonStyle
}
```

### Modifiers

```swift
// Styling
func accent() -> some View
func accent(_ color: Color) -> some View
func bordered() -> some View
func loading(_ isLoading: Bool) -> some View

// Environment Modifiers
func controlSize(_ size: ControlSize) -> some View
func controlBorderShape(_ shape: ControlBorderShape) -> some View
```

### Environment Values

```swift
@Environment(\.isLoading) var isLoading: Bool
@Environment(\.isAccent) var isAccent: Bool
@Environment(\.isBordered) var isBordered: Bool
```

## See Also

- ``Icon``
- ``Row``
- ``Surface``
- <doc:DesignSystem/Colors>
- <doc:Accessibility>
# Accessibility

Build inclusive applications that work for everyone with OversizeUI's comprehensive accessibility features.

## Overview

OversizeUI is designed with accessibility as a core principle, not an afterthought. Every component includes built-in accessibility features that comply with WCAG 2.1 guidelines and Apple's accessibility standards. This guide will help you leverage these features and implement additional accessibility enhancements in your applications.

### Accessibility Principles

- **Perceivable**: Information must be presentable in ways users can perceive
- **Operable**: Interface components must be operable by all users
- **Understandable**: Information and UI operation must be understandable
- **Robust**: Content must be robust enough for interpretation by assistive technologies

## Built-in Accessibility Features

### Automatic VoiceOver Support

All OversizeUI components automatically provide meaningful VoiceOver labels:

```swift
// Automatic accessibility label from button text
Button("Save Document") {
    saveDocument()
}
// VoiceOver reads: "Save Document, button"

// Automatic accessibility label from avatar initials
Avatar(firstName: "John", lastName: "Doe")
// VoiceOver reads: "John Doe"

// Automatic accessibility from text field placeholder
TextField("Enter your email", text: $email)
// VoiceOver reads: "Enter your email, text field"
```

### Dynamic Type Support

All typography automatically scales with Dynamic Type settings:

```swift
VStack {
    Text("Title")
        .title2() // Scales from -3 to +5 and accessibility sizes
    
    Text("Body text")
        .body() // Maintains relative hierarchy at all sizes
    
    Text("Caption")
        .caption() // Scales appropriately with larger text
}
```

### High Contrast Support

Colors automatically adapt to high contrast settings:

```swift
Text("Important information")
    .foregroundColor(.onSurfacePrimary) // Adapts to high contrast
    .background(.surfacePrimary) // Maintains proper contrast ratios
```

## Enhancing Component Accessibility

### Custom Accessibility Labels

Provide descriptive labels for complex components:

```swift
Button {
    toggleFavorite()
} label: {
    Icon(isFavorite ? .heartFill : .heart)
        .foregroundColor(isFavorite ? .red : .onSurfaceSecondary)
}
.accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")
.accessibilityHint("Double-tap to toggle favorite status")
```

### Accessibility Values and States

Communicate dynamic values and states:

```swift
struct ProgressIndicator: View {
    let progress: Double
    
    var body: some View {
        ProgressView(value: progress)
            .accessibilityLabel("Download progress")
            .accessibilityValue("\(Int(progress * 100)) percent complete")
    }
}

struct ToggleButton: View {
    @State private var isEnabled = false
    
    var body: some View {
        Button("Wi-Fi") {
            isEnabled.toggle()
        }
        .accessibilityLabel("Wi-Fi")
        .accessibilityValue(isEnabled ? "On" : "Off")
        .accessibilityHint("Double-tap to toggle Wi-Fi")
        .accessibilityAddTraits(isEnabled ? .isSelected : [])
    }
}
```

### Accessibility Actions

Provide additional context-specific actions:

```swift
struct MessageRow: View {
    let message: Message
    
    var body: some View {
        Row(message.subject) {
            VStack(alignment: .leading) {
                Text(message.sender)
                    .headline()
                Text(message.preview)
                    .body(.medium)
                    .foregroundColor(.onSurfaceSecondary)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Message from \(message.sender): \(message.subject)")
        .accessibilityAction(.activate) {
            openMessage()
        }
        .accessibilityAction(.delete) {
            deleteMessage()
        }
        .accessibilityAction(named: "Mark as read") {
            markAsRead()
        }
        .accessibilityAction(named: "Reply") {
            replyToMessage()
        }
    }
}
```

## Form Accessibility

### Accessible Form Design

```swift
struct AccessibleForm: View {
    @State private var name = ""
    @State private var email = ""
    @State private var age = ""
    @State private var newsletter = false
    
    var body: some View {
        Form {
            Section("Personal Information") {
                TextField("Full Name", text: $name)
                    .accessibilityLabel("Full name")
                    .accessibilityHint("Enter your first and last name")
                
                TextField("Email Address", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .accessibilityLabel("Email address")
                    .accessibilityHint("Enter your email for account creation")
                
                TextField("Age", text: $age)
                    .keyboardType(.numberPad)
                    .accessibilityLabel("Age")
                    .accessibilityHint("Enter your age in years")
            }
            
            Section("Preferences") {
                Toggle("Subscribe to newsletter", isOn: $newsletter)
                    .accessibilityHint("Receive weekly updates about new features")
            }
            
            Section {
                Button("Create Account") {
                    createAccount()
                }
                .buttonStyle(.primary)
                .frame(maxWidth: .infinity)
                .accessibilityHint("Create your new account with the provided information")
            }
        }
        .accessibilityElement(children: .contain)
    }
}
```

### Field Validation Accessibility

```swift
struct ValidatedTextField: View {
    @State private var email = ""
    @State private var isValid = true
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Email", text: $email)
                .textFieldStyle(.default)
                .onChange(of: email) { newValue in
                    isValid = isValidEmail(newValue)
                }
                .accessibilityLabel("Email address")
                .accessibilityValue(isValid ? "Valid email" : "Invalid email format")
            
            if !isValid {
                Text("Please enter a valid email address")
                    .caption()
                    .foregroundColor(.error)
                    .accessibilityLiveRegion(.polite) // Announces changes
            }
        }
    }
}
```

## Navigation Accessibility

### Accessible Navigation Structure

```swift
struct AccessibleNavigation: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(menuItems) { item in
                    NavigationLink(destination: item.destination) {
                        Row(item.title) {
                            HStack {
                                Icon(item.icon)
                                    .accessibilityHidden(true) // Icon is decorative
                                
                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .headline()
                                    
                                    if let subtitle = item.subtitle {
                                        Text(subtitle)
                                            .caption()
                                            .foregroundColor(.onSurfaceSecondary)
                                    }
                                }
                            }
                        }
                    }
                    .accessibilityLabel(item.title)
                    .accessibilityHint("Navigate to \(item.title) section")
                }
            }
            .navigationTitle("Settings")
            .accessibilityHeading(.h1) // Semantic heading structure
        }
    }
}
```

### Focus Management

```swift
struct FocusManagementExample: View {
    @FocusState private var focusedField: Field?
    @State private var name = ""
    @State private var email = ""
    
    enum Field {
        case name, email
    }
    
    var body: some View {
        VStack(spacing: .medium) {
            TextField("Name", text: $name)
                .focused($focusedField, equals: .name)
                .onSubmit {
                    focusedField = .email
                }
            
            TextField("Email", text: $email)
                .focused($focusedField, equals: .email)
                .onSubmit {
                    submitForm()
                }
            
            Button("Submit") {
                submitForm()
            }
            .buttonStyle(.primary)
        }
        .onAppear {
            // Focus first field when view appears
            focusedField = .name
        }
    }
}
```

## Visual Accessibility

### Color and Contrast

```swift
struct HighContrastDesign: View {
    var body: some View {
        VStack(spacing: .medium) {
            // ✅ High contrast text combinations
            Text("Primary content")
                .foregroundColor(.onSurfacePrimary) // 21:1 contrast
            
            Text("Secondary content")
                .foregroundColor(.onSurfaceSecondary) // 7:1 contrast
            
            Text("Tertiary content")
                .foregroundColor(.onSurfaceTertiary) // 4.5:1 contrast
            
            // ✅ Status with multiple indicators
            HStack {
                Circle()
                    .fill(.success)
                    .frame(width: 8, height: 8)
                
                Icon(.checkmark)
                    .foregroundColor(.success)
                
                Text("Success")
                    .foregroundColor(.success)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Operation successful")
        }
    }
}
```

### Reduced Motion Support

```swift
struct MotionSensitiveAnimation: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var isVisible = false
    
    var body: some View {
        VStack {
            Text("Content")
                .opacity(isVisible ? 1 : 0)
                .animation(
                    reduceMotion ? .none : .easeInOut(duration: 0.3),
                    value: isVisible
                )
            
            Button("Toggle") {
                isVisible.toggle()
            }
            .buttonStyle(.primary)
        }
    }
}
```

## Testing Accessibility

### Accessibility Audit Checklist

```swift
struct AccessibilityAuditView: View {
    var body: some View {
        VStack {
            // ✅ All interactive elements have labels
            Button("Save") { save() }
                .accessibilityLabel("Save document")
            
            // ✅ Decorative images are hidden
            Image("decorative-pattern")
                .accessibilityHidden(true)
            
            // ✅ Informative images have descriptions
            Image("chart-data")
                .accessibilityLabel("Sales increased 25% this quarter")
            
            // ✅ Form fields have clear labels
            TextField("Enter email", text: .constant(""))
                .accessibilityLabel("Email address")
            
            // ✅ Status updates are announced
            if isLoading {
                ProgressView("Loading...")
                    .accessibilityLabel("Loading content")
            }
        }
    }
}
```

### Automated Testing

```swift
import XCTest
import SwiftUI

class AccessibilityTests: XCTestCase {
    func testButtonAccessibility() {
        let button = Button("Save Document") { }
            .buttonStyle(.primary)
        
        // Test accessibility properties
        XCTAssertEqual(button.accessibilityLabel, "Save Document")
        XCTAssertTrue(button.isAccessibilityElement)
        XCTAssertEqual(button.accessibilityRole, .button)
    }
    
    func testDynamicTypeSupport() {
        let text = Text("Sample text")
            .body()
        
        // Test that text scales with Dynamic Type
        let smallSize = text.font(for: .small)
        let largeSize = text.font(for: .accessibilityLarge)
        
        XCTAssertNotEqual(smallSize, largeSize)
    }
}
```

## Platform-Specific Considerations

### iOS Accessibility Features

```swift
struct iOSAccessibilityFeatures: View {
    var body: some View {
        VStack {
            Button("Primary Action") {
                performAction()
            }
            .buttonStyle(.primary)
            .accessibilityAction(.magicTap) {
                // Quick action for Magic Tap gesture
                performAction()
            }
            
            List(items) { item in
                Row(item.title)
                    .accessibilityAction(.escape) {
                        // Back navigation for Escape gesture
                        dismiss()
                    }
            }
        }
    }
}
```

### macOS Accessibility Features

```swift
struct macOSAccessibilityFeatures: View {
    var body: some View {
        VStack {
            Button("Action") {
                performAction()
            }
            .keyboardShortcut(.defaultAction) // Enter key
            .accessibilityHelp("Performs the main action")
            
            TextField("Search", text: .constant(""))
                .accessibilityHelp("Type to search through items")
        }
    }
}
```

## Best Practices

### Do's

- ✅ Test with VoiceOver and other assistive technologies
- ✅ Use semantic color names that convey meaning
- ✅ Provide meaningful accessibility labels for all interactive elements
- ✅ Support Dynamic Type and test with larger font sizes
- ✅ Use proper heading hierarchy with `.accessibilityHeading()`
- ✅ Group related elements with `.accessibilityElement(children: .combine)`
- ✅ Respect user preferences for reduced motion and transparency

### Don'ts

- ❌ Don't rely solely on color to convey information
- ❌ Don't use vague labels like "Button" or "Image"
- ❌ Don't make touch targets smaller than 44x44 points
- ❌ Don't ignore accessibility when using custom gestures
- ❌ Don't forget to test with assistive technologies
- ❌ Don't override accessibility unless absolutely necessary

## Accessibility Resources

### Apple Documentation

- [Human Interface Guidelines - Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility)
- [Accessibility Programming Guide](https://developer.apple.com/accessibility/)
- [VoiceOver Testing Guide](https://developer.apple.com/documentation/accessibility/testing_your_app_s_accessibility)

### Testing Tools

- **Accessibility Inspector**: Built into Xcode for testing accessibility
- **VoiceOver**: Test screen reader functionality on device
- **Switch Control**: Test with alternative input methods
- **Simulator**: Test accessibility features in simulator

### WCAG Guidelines

- **Level A**: Basic accessibility compliance
- **Level AA**: Standard compliance (OversizeUI target)
- **Level AAA**: Enhanced compliance for specialized applications

## See Also

- <doc:Typography>
- <doc:Colors>
- <doc:BestPractices>
- ``Button``
- ``TextField``
- ``Avatar``
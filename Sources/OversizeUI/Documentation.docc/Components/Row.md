# Row

A versatile list row component for displaying content with consistent styling and accessibility.

## Overview

The `Row` component provides a standardized way to display list items with titles, subtitles, accessories, and actions. It ensures consistent spacing, typography, and accessibility across different contexts.

## Basic Usage

### Simple Row

```swift
Row("Settings")
```

### Row with Subtitle

```swift
Row("Notifications", subtitle: "Manage your alert preferences")
```

### Row with Leading Content

```swift
Row("Profile") {
    Icon(.person)
        .foregroundColor(.accent)
}
```

### Row with Trailing Content

```swift
Row("Dark Mode") {
    Toggle("", isOn: $isDarkMode)
}
```

## Practical Examples

### Settings List

```swift
List {
    Section("Account") {
        Row("Profile", subtitle: "Manage your personal information") {
            Icon(.person)
                .foregroundColor(.accent)
        }
        
        Row("Privacy", subtitle: "Control your data and privacy") {
            Icon(.shield)
                .foregroundColor(.accent)
        }
        
        Row("Security", subtitle: "Manage security settings") {
            Icon(.lock)
                .foregroundColor(.accent)
        }
    }
    
    Section("Preferences") {
        Row("Notifications") {
            HStack {
                Text("Enabled")
                    .caption(.medium)
                    .foregroundColor(.success)
                
                Toggle("", isOn: $notificationsEnabled)
            }
        }
        
        Row("Language") {
            Text("English")
                .caption()
                .foregroundColor(.onSurfaceSecondary)
        }
    }
}
```

### Contact List

```swift
List(contacts) { contact in
    Row(contact.fullName, subtitle: contact.phoneNumber) {
        HStack {
            Avatar(
                firstName: contact.firstName,
                lastName: contact.lastName
            )
            .controlSize(.small)
            
            Spacer()
            
            Button {
                callContact(contact)
            } label: {
                Icon(.phone)
            }
            .buttonStyle(.quaternary)
        }
    }
}
```

## Accessibility

Row components automatically provide:

- Proper VoiceOver labels combining title and subtitle
- Action accessibility for interactive elements
- Focus management for keyboard navigation

```swift
Row("Delete Account", subtitle: "This action cannot be undone") {
    Icon(.trash)
        .foregroundColor(.error)
}
.accessibilityLabel("Delete Account")
.accessibilityHint("This action cannot be undone")
```

## API Reference

### Initializers

```swift
Row(_ title: String)
Row(_ title: String, subtitle: String?)
Row<Content>(_ title: String, @ViewBuilder content: () -> Content)
Row<Content>(_ title: String, subtitle: String?, @ViewBuilder content: () -> Content)
```

## See Also

- ``SectionView``
- ``Avatar``
- ``Button``
# SectionView

A container component for grouping related content with headers and consistent styling.

## Overview

`SectionView` provides a standardized way to group related content with optional headers and footers. It ensures consistent spacing, typography, and visual hierarchy throughout your application.

## Basic Usage

### Simple Section

```swift
SectionView("Account Settings") {
    VStack(spacing: .small) {
        Row("Profile")
        Row("Privacy")
        Row("Security")
    }
}
```

### Section with Footer

```swift
SectionView("Notifications") {
    VStack(spacing: .small) {
        Row("Email Notifications") {
            Toggle("", isOn: $emailNotifications)
        }
        
        Row("Push Notifications") {
            Toggle("", isOn: $pushNotifications)
        }
    }
} footer: {
    Text("Notifications help you stay updated with important information.")
        .caption()
        .foregroundColor(.onSurfaceSecondary)
}
```

## Practical Examples

### Settings Form

```swift
struct SettingsForm: View {
    @State private var username = ""
    @State private var email = ""
    @State private var notifications = true
    @State private var darkMode = false
    
    var body: some View {
        VStack(spacing: .large) {
            SectionView("Account Information") {
                VStack(spacing: .medium) {
                    TextField("Username", text: $username)
                        .textFieldStyle(.default)
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(.default)
                        .keyboardType(.emailAddress)
                }
            }
            
            SectionView("Preferences") {
                VStack(spacing: .small) {
                    Row("Notifications") {
                        Toggle("", isOn: $notifications)
                    }
                    
                    Row("Dark Mode") {
                        Toggle("", isOn: $darkMode)
                    }
                }
            } footer: {
                Text("These settings affect how the app appears and behaves.")
                    .caption()
                    .foregroundColor(.onSurfaceSecondary)
            }
        }
        .padding()
    }
}
```

### Profile Information

```swift
struct ProfileInformation: View {
    let user: User
    
    var body: some View {
        VStack(spacing: .large) {
            SectionView("Personal Information") {
                VStack(spacing: .medium) {
                    Row("Full Name") {
                        Text(user.fullName)
                            .body(.medium)
                            .foregroundColor(.onSurfaceSecondary)
                    }
                    
                    Row("Email") {
                        Text(user.email)
                            .body(.medium)
                            .foregroundColor(.onSurfaceSecondary)
                    }
                    
                    Row("Phone") {
                        Text(user.phoneNumber)
                            .body(.medium)
                            .foregroundColor(.onSurfaceSecondary)
                    }
                }
            }
            
            SectionView("Account Details") {
                VStack(spacing: .medium) {
                    Row("Member Since") {
                        Text(user.memberSince.formatted())
                            .caption()
                            .foregroundColor(.onSurfaceSecondary)
                    }
                    
                    Row("Account Type") {
                        Text(user.accountType.displayName)
                            .caption(.medium)
                            .foregroundColor(.accent)
                    }
                }
            }
        }
        .padding()
    }
}
```

## Accessibility

SectionView automatically provides:
- Proper semantic structure for screen readers
- Header hierarchy with accessibility headings
- Grouped content for logical navigation

```swift
SectionView("Privacy Settings") {
    // Content
}
.accessibilityElement(children: .contain)
.accessibilityLabel("Privacy Settings section")
```

## API Reference

### Initializers

```swift
SectionView<Content>(_ title: String, @ViewBuilder content: () -> Content)

SectionView<Content, Footer>(_ title: String, @ViewBuilder content: () -> Content, @ViewBuilder footer: () -> Footer)
```

## See Also

- ``Row``
- ``Surface``
- ``TextField``
# NoticeView

Display alert banners and notifications with customizable styling and actions.

## Overview

`NoticeView` provides a flexible way to display important information, alerts, and notifications to users. It supports various styles, custom actions, and maintains accessibility standards.

## Basic Usage

### Simple Notice

```swift
NoticeView("Operation completed successfully!")
```

### Notice with Subtitle

```swift
NoticeView("Update Available", subtitle: "A new version of the app is available for download.")
```

### Notice with Actions

```swift
NoticeView("Confirm Action", subtitle: "This action cannot be undone.") {
    Button("Confirm") {
        performAction()
    }
    .buttonStyle(.primary)
    .controlSize(.small)
    
    Button("Cancel") {
        cancelAction()
    }
    .buttonStyle(.tertiary)
    .controlSize(.small)
} closeAction: {
    dismissNotice()
}
```

## Notice Types

### Success Notice

```swift
NoticeView("Success", subtitle: "Your changes have been saved.")
    .noticeStyle(.success)
```

### Warning Notice

```swift
NoticeView("Warning", subtitle: "Please review the following items before continuing.")
    .noticeStyle(.warning)
```

### Error Notice

```swift
NoticeView("Error", subtitle: "An error occurred while processing your request.")
    .noticeStyle(.error)
```

### Info Notice

```swift
NoticeView("Information", subtitle: "New features are available in the settings menu.")
    .noticeStyle(.info)
```

## Practical Examples

### Form Validation Notice

```swift
struct FormValidationNotice: View {
    let errors: [String]
    
    var body: some View {
        if !errors.isEmpty {
            NoticeView("Please correct the following errors:") {
                VStack(alignment: .leading, spacing: .xSmall) {
                    ForEach(errors, id: \.self) { error in
                        Text("• \(error)")
                            .caption()
                    }
                }
            } closeAction: {
                clearErrors()
            }
            .noticeStyle(.error)
        }
    }
}
```

### Update Banner

```swift
struct UpdateBanner: View {
    @State private var showBanner = true
    let updateInfo: UpdateInfo
    
    var body: some View {
        if showBanner {
            NoticeView("Update Available", subtitle: "Version \(updateInfo.version) is now available.") {
                Button("Update Now") {
                    startUpdate()
                }
                .buttonStyle(.primary)
                .controlSize(.small)
                
                Button("Later") {
                    showBanner = false
                }
                .buttonStyle(.tertiary)
                .controlSize(.small)
            } closeAction: {
                showBanner = false
            }
            .noticeStyle(.info)
        }
    }
}
```

### Connection Status

```swift
struct ConnectionStatus: View {
    @ObservedObject var networkMonitor: NetworkMonitor
    
    var body: some View {
        Group {
            if !networkMonitor.isConnected {
                NoticeView("No Internet Connection", subtitle: "Please check your network settings.") {
                    Button("Retry") {
                        networkMonitor.checkConnection()
                    }
                    .buttonStyle(.secondary)
                    .controlSize(.small)
                }
                .noticeStyle(.warning)
            }
        }
    }
}
```

## Accessibility

NoticeView automatically provides:
- VoiceOver announcements for important notices
- Proper focus management for actions
- Semantic labeling based on notice type

```swift
NoticeView("Critical Alert", subtitle: "Immediate action required.")
    .noticeStyle(.error)
    .accessibilityPriority(.high) // Prioritize for screen readers
```

## API Reference

### Initializers

```swift
NoticeView(_ title: String)
NoticeView(_ title: String, subtitle: String?)
NoticeView<Actions>(_ title: String, @ViewBuilder actions: () -> Actions)
NoticeView<Actions>(_ title: String, subtitle: String?, @ViewBuilder actions: () -> Actions, closeAction: (() -> Void)?)
```

### Styles

```swift
enum NoticeStyle {
    case `default`
    case success
    case warning
    case error
    case info
}
```

### Modifiers

```swift
func noticeStyle(_ style: NoticeStyle) -> some View
```

## See Also

- ``Button``
- ``Surface``
- ``SectionView``
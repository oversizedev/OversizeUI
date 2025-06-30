# Icon

Display SF Symbols and custom icons with consistent sizing and styling.

## Overview

The `Icon` component provides a unified interface for displaying SF Symbols and custom icons. It ensures consistent sizing, coloring, and accessibility across your application while maintaining platform conventions.

## Basic Usage

### SF Symbols

```swift
Icon(.heart)
    .foregroundColor(.red)

Icon(.star)
    .font(.title2)
    .foregroundColor(.yellow)
```

### System Icons

```swift
// Common interface icons
Icon(.plus)
Icon(.minus)
Icon(.xmark)

// Navigation icons
Icon(.chevronLeft)
Icon(.chevronRight)
Icon(.arrowUp)
Icon(.arrowDown)

// Communication icons
Icon(.message)
Icon(.phone)
Icon(.mail)
```

## Practical Examples

### Button with Icon

```swift
Button {
    addToFavorites()
} label: {
    HStack {
        Icon(.heart)
        Text("Add to Favorites")
    }
}
.buttonStyle(.primary)
```

### Status Indicators

```swift
struct StatusIndicator: View {
    let status: ConnectionStatus
    
    var body: some View {
        HStack {
            Icon(statusIcon)
                .foregroundColor(statusColor)
            
            Text(status.description)
                .body(.medium)
        }
    }
    
    private var statusIcon: IconsNames {
        switch status {
        case .connected: return .checkmark
        case .connecting: return .clock
        case .disconnected: return .xmark
        }
    }
    
    private var statusColor: Color {
        switch status {
        case .connected: return .success
        case .connecting: return .warning
        case .disconnected: return .error
        }
    }
}
```

### Icon Grid

```swift
struct IconShowcase: View {
    let icons: [IconsNames] = [.heart, .star, .bookmark, .share, .gear, .bell]
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
            ForEach(icons, id: \.self) { icon in
                VStack {
                    Icon(icon)
                        .font(.largeTitle)
                        .foregroundColor(.accent)
                    
                    Text(icon.rawValue)
                        .caption()
                }
                .padding()
            }
        }
    }
}
```

## Icon Categories

### Interface Icons
```swift
Icon(.plus)      // Add/Create
Icon(.minus)     // Remove/Subtract
Icon(.xmark)     // Close/Cancel
Icon(.checkmark) // Confirm/Success
```

### Navigation Icons
```swift
Icon(.chevronLeft)  // Back navigation
Icon(.chevronRight) // Forward navigation
Icon(.arrowUp)      // Move up
Icon(.arrowDown)    // Move down
```

### Communication Icons
```swift
Icon(.message)  // Messages/Chat
Icon(.phone)    // Phone calls
Icon(.video)    // Video calls
Icon(.mail)     // Email
```

### Media Icons
```swift
Icon(.play)   // Play media
Icon(.pause)  // Pause media
Icon(.stop)   // Stop media
Icon(.camera) // Take photo
```

### System Icons
```swift
Icon(.gear)     // Settings
Icon(.shield)   // Security
Icon(.lock)     // Locked/Private
Icon(.wifi)     // Network/Connectivity
```

## Customization

### Size and Color

```swift
Icon(.star)
    .font(.title)
    .foregroundColor(.yellow)

Icon(.heart)
    .frame(width: 24, height: 24)
    .foregroundColor(.red)
```

### Custom Styling

```swift
Icon(.bookmark)
    .font(.title2)
    .foregroundColor(.white)
    .background(Circle().fill(.accent))
    .frame(width: 40, height: 40)
```

## Accessibility

Icons automatically provide accessibility support:

```swift
// Decorative icons (hidden from VoiceOver)
Icon(.chevronRight)
    .accessibilityHidden(true)

// Informative icons (with labels)
Icon(.warning)
    .accessibilityLabel("Warning")

// Interactive icons (with labels and hints)
Button {
    deleteItem()
} label: {
    Icon(.trash)
}
.accessibilityLabel("Delete")
.accessibilityHint("Delete this item permanently")
```

## API Reference

### Icon Names

```swift
enum IconsNames: String, CaseIterable {
    // Interface
    case plus, minus, xmark, checkmark
    
    // Navigation
    case chevronLeft, chevronRight, chevronUp, chevronDown
    case arrowLeft, arrowRight, arrowUp, arrowDown
    
    // Communication
    case message, phone, video, mail
    
    // Media
    case play, pause, stop, camera, photo
    
    // System
    case gear, shield, lock, wifi, bell
    
    // Content
    case heart, star, bookmark, share
    
    // Custom
    case custom(String)
}
```

### Initializers

```swift
Icon(_ name: IconsNames)
Icon(_ systemName: String) // Direct SF Symbol access
```

## See Also

- ``Button``
- ``Row``
- ``Avatar``
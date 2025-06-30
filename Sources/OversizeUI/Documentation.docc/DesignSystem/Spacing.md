# Spacing

A consistent spacing system that creates visual rhythm and hierarchy throughout your interface.

## Overview

OversizeUI's spacing system provides a set of predefined spacing tokens that ensure consistent layout and visual rhythm across your application. The spacing scale is designed to work harmoniously with typography and creates clear relationships between interface elements.

### Spacing Scale

The spacing system uses a consistent scale based on multiples of 4:

```swift
// Available spacing tokens
.xxSmall  // 2pt
.xSmall   // 4pt
.small    // 8pt
.medium   // 16pt
.large    // 24pt
.xLarge   // 32pt
.xxLarge  // 48pt
```

## Basic Usage

### Padding

Apply consistent padding using spacing tokens:

```swift
VStack {
    Text("Content with consistent spacing")
        .padding(.medium) // 16pt padding
    
    Button("Action") { }
        .padding(.horizontal, .large) // 24pt horizontal
        .padding(.vertical, .small)   // 8pt vertical
}
```

### Stack Spacing

Use spacing tokens for stack spacing:

```swift
VStack(spacing: .medium) { // 16pt between elements
    Text("Title")
    Text("Subtitle")
    Button("Action") { }
}

HStack(spacing: .small) { // 8pt between elements
    Icon(.star)
    Text("Rating")
}
```

## Practical Examples

### Card Layout

```swift
Surface {
    VStack(alignment: .leading, spacing: .medium) {
        Text("Card Title")
            .headline()
        
        Text("Card description with proper spacing")
            .body()
        
        HStack(spacing: .small) {
            Button("Primary") { }
                .buttonStyle(.primary)
            
            Button("Secondary") { }
                .buttonStyle(.secondary)
        }
    }
    .padding(.large) // Consistent card padding
}
```

### Form Layout

```swift
VStack(spacing: .large) { // Large spacing between sections
    VStack(spacing: .medium) { // Medium spacing within sections
        TextField("Name", text: $name)
        TextField("Email", text: $email)
    }
    
    VStack(spacing: .medium) {
        TextField("Address", text: $address)
        TextField("City", text: $city)
    }
    
    Button("Submit") { }
        .buttonStyle(.primary)
        .padding(.top, .medium) // Additional top spacing
}
.padding(.large) // Container padding
```

## API Reference

### Spacing Values

```swift
extension CGFloat {
    static let xxSmall: CGFloat = 2
    static let xSmall: CGFloat = 4
    static let small: CGFloat = 8
    static let medium: CGFloat = 16
    static let large: CGFloat = 24
    static let xLarge: CGFloat = 32
    static let xxLarge: CGFloat = 48
}
```

## See Also

- <doc:Typography>
- <doc:Colors>
- ``Surface``
- ``SectionView``
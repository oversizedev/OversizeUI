# Icons

A comprehensive icon system with over 1000 icons and support for custom iconography.

## Overview

OversizeUI's icon system provides access to SF Symbols and custom icons through a unified interface. The system ensures consistent sizing, styling, and accessibility across all icons while maintaining platform conventions.

## Basic Usage

### SF Symbols

```swift
Icon(.heart)
    .foregroundColor(.accent)

Icon(.star)
    .font(.title2)
    .foregroundColor(.warning)
```

### Custom Icons

```swift
Icon(.custom("my-custom-icon"))
    .frame(width: 24, height: 24)
```

## Icon Categories

### Interface Icons
- `.plus`, `.minus`, `.xmark`
- `.chevronUp`, `.chevronDown`, `.chevronLeft`, `.chevronRight`
- `.arrowUp`, `.arrowDown`, `.arrowLeft`, `.arrowRight`

### Communication Icons
- `.message`, `.phone`, `.video`
- `.mail`, `.bell`, `.share`

### Media Icons
- `.play`, `.pause`, `.stop`
- `.camera`, `.photo`, `.music`

### System Icons
- `.gear`, `.wrench`, `.questionmark`
- `.shield`, `.lock`, `.wifi`

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

### Icon Grid

```swift
LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
    ForEach(IconsNames.allCases, id: \.self) { icon in
        VStack {
            Icon(icon)
                .font(.title2)
            
            Text(icon.rawValue)
                .caption()
        }
    }
}
```

## Accessibility

Icons automatically provide accessibility labels:

```swift
Icon(.trash)
    .accessibilityLabel("Delete")
    .accessibilityHint("Delete this item")
```

## See Also

- ``Button``
- ``Row``
- <doc:Accessibility>
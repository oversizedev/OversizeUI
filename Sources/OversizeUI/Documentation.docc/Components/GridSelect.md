# GridSelect

A flexible multi-selection grid component for choosing from collections of items.

## Overview

`GridSelect` provides an elegant way to display and select from collections of items in a grid layout. It supports single and multi-selection modes with customizable content and selection indicators.

## Basic Usage

### Simple Grid Selection

```swift
@State private var selectedItems: Set<String> = []
let options = ["Swift", "SwiftUI", "Xcode", "iOS"]

GridSelect(options, selection: $selectedItems) { item, isSelected in
    VStack {
        Icon(.swift)
            .foregroundColor(isSelected ? .white : .primary)
        
        Text(item)
            .caption(.medium)
    }
    .padding()
    .background(isSelected ? Color.accent : Color.surfaceSecondary)
    .cornerRadius(.medium)
}
```

### Single Selection Mode

```swift
@State private var selectedItem: String? = nil
let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

GridSelect(platforms, selection: $selectedItem) { platform, isSelected in
    VStack {
        platformIcon(for: platform)
        Text(platform)
            .body(.medium)
    }
    .padding()
    .background(isSelected ? Color.accent : Color.clear)
    .overlay(
        RoundedRectangle(cornerRadius: .medium)
            .stroke(isSelected ? Color.accent : Color.border, lineWidth: 1)
    )
}
```

## Customization

### Grid Layout

```swift
GridSelect(items, selection: $selection, columns: 3) { item, isSelected in
    // Custom content
}
```

### Custom Selection Indicators

```swift
GridSelect(items, selection: $selection) { item, isSelected in
    VStack {
        Text(item.title)
            .headline(.medium)
        
        Text(item.description)
            .caption()
    }
    .padding()
    .overlay(alignment: .topTrailing) {
        if isSelected {
            Icon(.checkmark)
                .foregroundColor(.white)
                .background(Circle().fill(.accent))
                .padding(.xSmall)
        }
    }
}
```

## Practical Examples

### Category Selection

```swift
struct CategorySelection: View {
    @State private var selectedCategories: Set<Category> = []
    let categories = Category.allCases
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select Categories")
                .title3(.bold)
            
            GridSelect(categories, selection: $selectedCategories) { category, isSelected in
                VStack(spacing: .small) {
                    Icon(category.icon)
                        .font(.title2)
                        .foregroundColor(isSelected ? .white : category.color)
                    
                    Text(category.name)
                        .caption(.medium)
                        .foregroundColor(isSelected ? .white : .onSurfacePrimary)
                }
                .frame(height: 80)
                .frame(maxWidth: .infinity)
                .background(isSelected ? category.color : .surfaceSecondary)
                .cornerRadius(.medium)
            }
        }
    }
}
```

### Size Selection

```swift
struct SizeSelection: View {
    @State private var selectedSize: ClothingSize? = nil
    let sizes = ClothingSize.allCases
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Size")
                .headline()
            
            GridSelect(sizes, selection: $selectedSize, columns: 4) { size, isSelected in
                Text(size.abbreviation)
                    .body(.semibold)
                    .foregroundColor(isSelected ? .white : .onSurfacePrimary)
                    .frame(width: 44, height: 44)
                    .background(isSelected ? Color.accent : Color.clear)
                    .overlay(
                        Circle()
                            .stroke(isSelected ? Color.clear : Color.border, lineWidth: 1)
                    )
            }
        }
    }
}
```

## Accessibility

GridSelect provides automatic accessibility support:

```swift
GridSelect(items, selection: $selection) { item, isSelected in
    // Content
}
.accessibilityLabel("Item selection grid")
.accessibilityHint("Choose one or more items from the available options")
```

Individual grid items automatically receive:
- Selection state announcements
- Proper focus management
- Action descriptions

## API Reference

### Initializers

```swift
// Multi-selection
GridSelect<Item>(_ items: [Item], selection: Binding<Set<Item>>, content: @escaping (Item, Bool) -> Content)

// Single selection
GridSelect<Item>(_ items: [Item], selection: Binding<Item?>, content: @escaping (Item, Bool) -> Content)

// Custom columns
GridSelect<Item>(_ items: [Item], selection: Binding<Set<Item>>, columns: Int, content: @escaping (Item, Bool) -> Content)
```

### Modifiers

```swift
func gridSelectStyle(_ style: GridSelectStyle) -> some View
```

## See Also

- ``Select``
- ``SegmentedControl``
- ``Button``
- <doc:Accessibility>
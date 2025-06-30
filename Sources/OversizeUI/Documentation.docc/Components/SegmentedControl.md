# SegmentedControl

A modern segmented control with island-style design for selecting between multiple options.

## Overview

The `SegmentedControl` component provides an elegant way to let users choose between multiple options. It features a modern island-style design that clearly indicates the selected option while maintaining accessibility standards.

## Basic Usage

### Simple Segmented Control

```swift
@State private var selectedView = "List"
let viewOptions = ["List", "Grid", "Card"]

SegmentedPickerSelector(viewOptions, selection: $selectedView) { option, _ in
    Text(option)
}
```

### Island Style

```swift
SegmentedPickerSelector(options, selection: $selection) { option, _ in
    Text(option)
}
.segmentedControlStyle(.island)
```

## Practical Examples

### View Mode Selector

```swift
enum ViewMode: String, CaseIterable {
    case list = "List"
    case grid = "Grid"
    case card = "Card"
    
    var icon: IconsNames {
        switch self {
        case .list: return .list
        case .grid: return .grid
        case .card: return .square
        }
    }
}

struct ViewModeSelector: View {
    @State private var selectedMode: ViewMode = .list
    
    var body: some View {
        SegmentedPickerSelector(ViewMode.allCases, selection: $selectedMode) { mode, _ in
            HStack(spacing: .xSmall) {
                Icon(mode.icon)
                Text(mode.rawValue)
            }
        }
        .segmentedControlStyle(.island)
    }
}
```

### Tab Selector

```swift
@State private var selectedTab = 0
let tabs = ["Overview", "Details", "Reviews"]

SegmentedPickerSelector(Array(tabs.enumerated()), selection: $selectedTab) { (index, title), _ in
    Text(title)
}
.segmentedControlStyle(.island)
```

## Accessibility

SegmentedControl automatically provides:
- VoiceOver support with option descriptions
- Keyboard navigation
- Selection state announcements

```swift
SegmentedPickerSelector(options, selection: $selection) { option, _ in
    Text(option)
}
.accessibilityLabel("View mode selection")
.accessibilityHint("Choose how to display the content")
```

## API Reference

### Initializers

```swift
SegmentedPickerSelector<Item>(_ items: [Item], selection: Binding<Item>, content: @escaping (Item, Bool) -> Content)
```

### Styles

```swift
enum SegmentedControlStyle {
    case standard
    case island
}
```

## See Also

- ``Select``
- ``GridSelect``
- ``Button``
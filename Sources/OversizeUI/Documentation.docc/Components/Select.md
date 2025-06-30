# Select

A dropdown selection component with search functionality and custom content support.

## Overview

The `Select` component provides an elegant dropdown interface for choosing from lists of options. It supports search functionality, custom content rendering, and maintains accessibility standards.

## Basic Usage

### Simple Select

```swift
@State private var selectedCountry = ""
let countries = ["United States", "Canada", "United Kingdom", "Australia"]

Select("Choose Country", countries, selection: $selectedCountry) { country, _ in
    Text(country)
} selectionView: { selected in
    Text(selected.isEmpty ? "Select Country" : selected)
}
```

### Select with Icons

```swift
@State private var selectedPlatform = ""
let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

Select("Platform", platforms, selection: $selectedPlatform) { platform, _ in
    HStack {
        Icon(platformIcon(for: platform))
        Text(platform)
    }
} selectionView: { selected in
    if let selected = selected, !selected.isEmpty {
        HStack {
            Icon(platformIcon(for: selected))
            Text(selected)
        }
    } else {
        Text("Choose Platform")
            .foregroundColor(.onSurfaceSecondary)
    }
}
```

## Practical Examples

### Settings Selector

```swift
struct LanguageSelector: View {
    @State private var selectedLanguage = "English"
    let languages = ["English", "Spanish", "French", "German", "Chinese"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Language")
                .headline()
            
            Select("Language", languages, selection: $selectedLanguage) { language, _ in
                HStack {
                    Text(languageFlag(for: language))
                    Text(language)
                    Spacer()
                }
            } selectionView: { selected in
                HStack {
                    if let selected = selected {
                        Text(languageFlag(for: selected))
                        Text(selected)
                    } else {
                        Text("Select Language")
                            .foregroundColor(.onSurfaceSecondary)
                    }
                    Spacer()
                    Icon(.chevronDown)
                        .foregroundColor(.onSurfaceSecondary)
                }
            }
        }
    }
}
```

### Multi-Select

```swift
@State private var selectedTags: Set<String> = []
let availableTags = ["Swift", "SwiftUI", "iOS", "macOS", "Design", "Architecture"]

Select("Tags", availableTags, selection: $selectedTags) { tag, isSelected in
    HStack {
        Text(tag)
        Spacer()
        if isSelected {
            Icon(.checkmark)
                .foregroundColor(.accent)
        }
    }
} selectionView: { selectedSet in
    if selectedSet.isEmpty {
        Text("Choose Tags")
            .foregroundColor(.onSurfaceSecondary)
    } else {
        Text("\(selectedSet.count) tags selected")
    }
}
```

## Search Integration

```swift
@State private var searchText = ""
@State private var selectedUser = ""

let filteredUsers = users.filter { user in
    searchText.isEmpty || user.lowercased().contains(searchText.lowercased())
}

Select("Assign to", filteredUsers, selection: $selectedUser, searchText: $searchText) { user, _ in
    HStack {
        Avatar(firstName: user.firstName, lastName: user.lastName)
            .controlSize(.small)
        
        VStack(alignment: .leading) {
            Text(user.fullName)
                .body(.medium)
            Text(user.email)
                .caption()
                .foregroundColor(.onSurfaceSecondary)
        }
    }
} selectionView: { selected in
    if let selected = selected {
        HStack {
            Avatar(firstName: selected.firstName, lastName: selected.lastName)
                .controlSize(.small)
            Text(selected.fullName)
        }
    } else {
        Text("Select User")
            .foregroundColor(.onSurfaceSecondary)
    }
}
```

## Accessibility

Select components provide:
- VoiceOver support with option descriptions
- Keyboard navigation through options
- Search functionality with VoiceOver announcements
- Proper focus management

```swift
Select("Priority", priorities, selection: $selectedPriority) { priority, _ in
    Text(priority.name)
} selectionView: { selected in
    Text(selected?.name ?? "Select Priority")
}
.accessibilityLabel("Priority selection")
.accessibilityHint("Choose the priority level for this task")
```

## API Reference

### Initializers

```swift
// Single selection
Select<Item>(_ title: String, _ items: [Item], selection: Binding<Item?>, content: @escaping (Item, Bool) -> Content, selectionView: @escaping (Item?) -> SelectionContent)

// Multi-selection
Select<Item>(_ title: String, _ items: [Item], selection: Binding<Set<Item>>, content: @escaping (Item, Bool) -> Content, selectionView: @escaping (Set<Item>) -> SelectionContent)

// With search
Select<Item>(_ title: String, _ items: [Item], selection: Binding<Item?>, searchText: Binding<String>, content: @escaping (Item, Bool) -> Content, selectionView: @escaping (Item?) -> SelectionContent)
```

## See Also

- ``GridSelect``
- ``SegmentedControl``
- ``TextField``
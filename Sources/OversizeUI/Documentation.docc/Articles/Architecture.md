# Architecture

Learn about OversizeUI's architectural principles and how to build scalable, maintainable applications.

## Overview

OversizeUI is architected with SwiftUI's declarative paradigm in mind, providing a foundation that scales from simple prototypes to complex production applications. The architecture emphasizes composition, reusability, and maintainability while staying true to SwiftUI's native patterns.

## Core Architectural Principles

### 1. Composition Over Inheritance

OversizeUI favors composition patterns that make components more flexible and testable:

```swift
// ✅ Composition - Flexible and reusable
struct ProfileCard: View {
    let user: User
    
    var body: some View {
        Surface {
            VStack(spacing: .medium) {
                Avatar(firstName: user.firstName, lastName: user.lastName)
                    .controlSize(.large)
                
                Text(user.fullName)
                    .headline()
                
                Button("View Profile") {
                    // Action
                }
                .buttonStyle(.primary)
            }
            .padding()
        }
    }
}

// ❌ Inheritance - Less flexible
class CustomButton: OversizeButton {
    // Difficult to extend and maintain
}
```

### 2. Single Responsibility Components

Each component has a clear, focused purpose:

```swift
// ✅ Single responsibility
struct UserAvatar: View {
    let user: User
    
    var body: some View {
        Avatar(firstName: user.firstName, lastName: user.lastName)
            .controlSize(.medium)
    }
}

struct UserInfo: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(user.fullName).headline()
            Text(user.email).body(.medium)
        }
    }
}

// ✅ Composed from focused components
struct UserRow: View {
    let user: User
    
    var body: some View {
        Row {
            HStack {
                UserAvatar(user: user)
                UserInfo(user: user)
                Spacer()
            }
        }
    }
}
```

### 3. Declarative State Management

Leverage SwiftUI's declarative nature for predictable state management:

```swift
struct TodoListView: View {
    @StateObject private var viewModel = TodoListViewModel()
    
    var body: some View {
        VStack {
            // UI automatically updates when state changes
            ForEach(viewModel.todos) { todo in
                TodoRow(todo: todo) {
                    viewModel.toggle(todo)
                }
            }
            
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.loadTodos()
        }
    }
}
```

## Design System Architecture

### Component Hierarchy

OversizeUI follows a hierarchical component structure:

```
Foundation Layer
├── Colors (Semantic color system)
├── Typography (Text styles and hierarchy)
├── Spacing (Layout spacing tokens)
└── Icons (Icon system and assets)

Core Components
├── Surface (Base container component)
├── Button (Interactive actions)
├── TextField (Text input)
└── Avatar (User representation)

Composite Components
├── Row (List items with accessories)
├── SectionView (Grouped content)
├── NoticeView (Alerts and notifications)
└── Select (Dropdown selection)

Layout Components
├── VStack, HStack (Enhanced stacks)
├── GridSelect (Selection grids)
└── ScrollView (Enhanced scrolling)
```

### Theme System Architecture

```swift
// Theme settings as a single source of truth
@StateObject private var theme = ThemeSettings()

WindowGroup {
    ContentView()
        .environmentObject(theme) // Propagates to all components
}

// Components access theme through environment
struct MyComponent: View {
    @Environment(\.theme) private var theme: ThemeSettings
    
    var body: some View {
        Text("Themed content")
            .foregroundColor(theme.accentColor)
    }
}
```

## Data Flow Patterns

### Unidirectional Data Flow

Follow SwiftUI's unidirectional data flow principles:

```swift
// State flows down, events flow up
struct ParentView: View {
    @State private var selectedItems: Set<String> = []
    
    var body: some View {
        VStack {
            // State flows down to child
            ItemList(
                items: items,
                selectedItems: selectedItems
            ) { newSelection in
                // Events flow up from child
                selectedItems = newSelection
            }
            
            ActionBar(
                selectionCount: selectedItems.count,
                onClearSelection: {
                    selectedItems.removeAll()
                }
            )
        }
    }
}
```

### State Management Patterns

#### Local State for Simple UI

```swift
struct Counter: View {
    @State private var count = 0
    
    var body: some View {
        HStack {
            Button("-") { count -= 1 }
                .buttonStyle(.secondary)
            
            Text("\(count)")
                .title3()
            
            Button("+") { count += 1 }
                .buttonStyle(.secondary)
        }
    }
}
```

#### ObservableObject for Complex State

```swift
class UserProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func updateProfile() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            user = try await userService.updateProfile(user)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

struct UserProfileView: View {
    @StateObject private var viewModel: UserProfileViewModel
    
    var body: some View {
        Form {
            // Form fields bound to viewModel.user
        }
        .loading(viewModel.isLoading)
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK") { viewModel.errorMessage = nil }
        }
    }
}
```

## Component Design Patterns

### Builder Pattern for Complex Components

```swift
struct NoticeView {
    // Use builder pattern for complex configurations
    static func success(_ message: String) -> NoticeView {
        NoticeView(message, style: .success)
    }
    
    static func error(_ message: String) -> NoticeView {
        NoticeView(message, style: .error)
    }
    
    static func warning(_ message: String) -> NoticeView {
        NoticeView(message, style: .warning)
    }
}

// Usage
NoticeView.success("Operation completed!")
NoticeView.error("Something went wrong")
```

### Modifier Pattern for Customization

```swift
extension View {
    func cardStyle() -> some View {
        self
            .padding()
            .background(.surfacePrimary)
            .cornerRadius(.medium)
            .shadow(.small)
    }
    
    func primaryAction() -> some View {
        self
            .buttonStyle(.primary)
            .controlSize(.large)
            .accent()
    }
}

// Usage
VStack {
    Text("Card content")
}
.cardStyle()

Button("Save") { save() }
    .primaryAction()
```

### Container Pattern for Layout

```swift
struct CardContainer<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Surface {
            content
                .padding()
        }
        .background(.surfacePrimary)
        .cornerRadius(.medium)
        .elevation(.small)
    }
}

// Usage
CardContainer {
    VStack {
        Text("Title")
        Text("Content")
    }
}
```

## Testing Architecture

### Component Testing

```swift
import XCTest
import SwiftUI
@testable import OversizeUI

class ButtonTests: XCTestCase {
    func testButtonAccentColor() {
        let theme = ThemeSettings()
        theme.accentColor = .blue
        
        let button = Button("Test") { }
            .buttonStyle(.primary)
            .accent()
            .environmentObject(theme)
        
        // Test button properties
        XCTAssertEqual(button.accentColor, .blue)
    }
    
    func testButtonAccessibility() {
        let button = Button("Save Document") { }
            .buttonStyle(.primary)
        
        // Test accessibility properties
        XCTAssertEqual(button.accessibilityLabel, "Save Document")
        XCTAssertTrue(button.isAccessibilityElement)
    }
}
```

### Preview Testing

```swift
struct ButtonPreviews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: .medium) {
            Button("Primary") { }
                .buttonStyle(.primary)
            
            Button("Secondary") { }
                .buttonStyle(.secondary)
            
            Button("Disabled") { }
                .buttonStyle(.primary)
                .disabled(true)
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.light)
        
        // Dark mode preview
        VStack(spacing: .medium) {
            Button("Primary") { }
                .buttonStyle(.primary)
            
            Button("Secondary") { }
                .buttonStyle(.secondary)
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
}
```

## Performance Considerations

### Lazy Loading

```swift
struct LargeList: View {
    let items: [Item]
    
    var body: some View {
        LazyVStack {
            ForEach(items) { item in
                ItemRow(item: item)
                    .onAppear {
                        // Load additional data when needed
                        loadMoreIfNeeded(item)
                    }
            }
        }
    }
}
```

### Efficient State Updates

```swift
class ListViewModel: ObservableObject {
    @Published var items: [Item] = []
    
    func updateItem(_ item: Item) {
        // ✅ Efficient - only updates specific item
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
        }
        
        // ❌ Inefficient - triggers full list update
        // items = items.map { $0.id == item.id ? item : $0 }
    }
}
```

### Memory Management

```swift
struct AsyncImageView: View {
    @StateObject private var loader = ImageLoader()
    let url: URL
    
    var body: some View {
        AsyncImage(url: url) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .onDisappear {
            // Clean up resources when view disappears
            loader.cancel()
        }
    }
}
```

## Best Practices

### Component Organization

```
Sources/
├── OversizeUI/
│   ├── Controls/          # Interactive components
│   │   ├── Button/
│   │   ├── TextField/
│   │   └── Avatar/
│   ├── Core/              # Foundation systems
│   │   ├── Colors.swift
│   │   ├── Typography.swift
│   │   └── Spacing.swift
│   ├── Layouts/           # Layout components
│   └── Extensions/        # SwiftUI extensions
```

### Naming Conventions

```swift
// ✅ Clear, descriptive names
struct UserProfileCard: View { }
struct ProductListRow: View { }
struct SettingsToggleRow: View { }

// ✅ Consistent modifier naming
func primaryAction() -> some View
func cardStyle() -> some View
func destructiveAction() -> some View

// ✅ Semantic environment values
@Environment(\.theme) var theme
@Environment(\.isLoading) var isLoading
```

### Documentation Standards

```swift
/// A card component that displays user profile information.
///
/// Use `UserProfileCard` to present user details in a consistent,
/// visually appealing format across your application.
///
/// ```swift
/// UserProfileCard(user: currentUser)
///     .onTap { viewModel.showUserDetails() }
/// ```
///
/// ## Topics
/// 
/// ### Creating a Profile Card
/// - ``init(user:)``
/// 
/// ### Customizing Appearance
/// - ``cardStyle(_:)``
/// - ``showsEditButton(_:)``
///
/// - Parameters:
///   - user: The user whose profile information to display
public struct UserProfileCard: View {
    // Implementation
}
```

## Migration and Versioning

### API Evolution

```swift
// Version 3.0 - Current API
Button("Save") { save() }
    .buttonStyle(.primary)

// Version 4.0 - Planned evolution
@available(iOS 16.0, *)
extension ButtonStyle {
    static var primary: some ButtonStyle {
        // Enhanced implementation
    }
}

// Deprecation pattern
@available(*, deprecated, renamed: "buttonStyle(.primary)")
func primaryButtonStyle() -> some View {
    buttonStyle(.primary)
}
```

### Backward Compatibility

```swift
// Support multiple API versions
extension View {
    @ViewBuilder
    func compatibleBackground(_ color: Color) -> some View {
        if #available(iOS 15.0, *) {
            background(color, ignoresSafeAreaEdges: .all)
        } else {
            background(color)
        }
    }
}
```

## See Also

- <doc:BestPractices>
- <doc:Theming>
- <doc:Accessibility>
- ``Surface``
- ``Button``
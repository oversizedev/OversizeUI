# Best Practices

Guidelines and patterns for building exceptional user experiences with OversizeUI.

## Overview

This guide provides best practices, patterns, and recommendations for building high-quality applications with OversizeUI. Following these guidelines will help you create consistent, accessible, and maintainable interfaces.

## Component Usage Guidelines

### Button Best Practices

```swift
// ✅ Use semantic button styles
Button("Save Document") { save() }
    .buttonStyle(.primary) // Clear primary action

Button("Cancel") { cancel() }
    .buttonStyle(.tertiary) // Secondary action

// ✅ Provide clear, action-oriented labels
Button("Delete Photo") { deletePhoto() }
    .buttonStyle(.primary)
    .accent(.red)

// ❌ Avoid vague labels
Button("OK") { } // What does OK do?
```

### TextField Best Practices

```swift
// ✅ Provide helpful placeholder text
TextField("Enter your email address", text: $email)
    .keyboardType(.emailAddress)
    .autocapitalization(.none)

// ✅ Use validation appropriately
TextField("Password", text: $password)
    .fieldHelper(passwordStrength, style: $helperStyle)
    .onChange(of: password) { validatePassword($0) }

// ❌ Don't use placeholder as label
TextField("Email", text: $email) // Placeholder disappears when typing
```

### Layout Best Practices

```swift
// ✅ Use consistent spacing
VStack(spacing: .medium) { // Consistent spacing token
    Text("Title")
    Text("Content")
}

// ✅ Group related content
SectionView("Account Settings") {
    VStack(spacing: .small) {
        Row("Profile")
        Row("Privacy")
        Row("Security")
    }
}

// ❌ Inconsistent spacing
VStack(spacing: 17) { // Arbitrary value
    Text("Title")
    Text("Content")
}
```

## Performance Optimization

### Efficient List Rendering

```swift
// ✅ Use LazyVStack for large lists
LazyVStack {
    ForEach(items) { item in
        ItemRow(item: item)
            .onAppear {
                loadMoreIfNeeded(item)
            }
    }
}

// ✅ Minimize state updates
class ListViewModel: ObservableObject {
    @Published var items: [Item] = []
    
    func updateItem(_ item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item // Targeted update
        }
    }
}
```

### Memory Management

```swift
// ✅ Clean up resources
struct AsyncImageView: View {
    @StateObject private var loader = ImageLoader()
    
    var body: some View {
        AsyncImage(url: url)
            .onDisappear {
                loader.cancel() // Clean up when view disappears
            }
    }
}
```

## State Management Patterns

### Local State for Simple UI

```swift
// ✅ Use @State for simple, local state
struct ToggleView: View {
    @State private var isEnabled = false
    
    var body: some View {
        Toggle("Feature", isOn: $isEnabled)
    }
}
```

### ObservableObject for Complex State

```swift
// ✅ Use ObservableObject for complex state
class UserProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func updateProfile() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            user = try await userService.updateProfile(user)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
```

## Accessibility Best Practices

### Semantic Structure

```swift
// ✅ Use proper heading hierarchy
VStack(alignment: .leading) {
    Text("Main Title")
        .title()
        .accessibilityHeading(.h1)
    
    Text("Section Title")
        .title2()
        .accessibilityHeading(.h2)
    
    Text("Content")
        .body()
}
```

### Meaningful Labels

```swift
// ✅ Provide descriptive accessibility labels
Button {
    toggleFavorite()
} label: {
    Icon(isFavorite ? .heartFill : .heart)
}
.accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")
.accessibilityHint("Double-tap to toggle favorite status")

// ✅ Group related elements
HStack {
    Avatar(firstName: user.firstName, lastName: user.lastName)
    VStack(alignment: .leading) {
        Text(user.fullName)
        Text(user.email)
    }
}
.accessibilityElement(children: .combine)
.accessibilityLabel("\(user.fullName), \(user.email)")
```

## Error Handling

### User-Friendly Error Messages

```swift
// ✅ Provide helpful error messages
struct ErrorView: View {
    let error: AppError
    let retry: () -> Void
    
    var body: some View {
        VStack(spacing: .medium) {
            Icon(.exclamationmark)
                .font(.largeTitle)
                .foregroundColor(.error)
            
            Text(error.userFriendlyMessage)
                .headline()
                .multilineTextAlignment(.center)
            
            Text(error.suggestions)
                .body()
                .foregroundColor(.onSurfaceSecondary)
                .multilineTextAlignment(.center)
            
            Button("Try Again") {
                retry()
            }
            .buttonStyle(.primary)
        }
        .padding()
    }
}
```

### Graceful Degradation

```swift
// ✅ Handle loading and error states
struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = viewModel.error {
                ErrorView(error: error) {
                    viewModel.reload()
                }
            } else {
                ContentList(items: viewModel.items)
            }
        }
        .onAppear {
            viewModel.loadContent()
        }
    }
}
```

## Testing Guidelines

### Component Testing

```swift
// ✅ Test component behavior
import XCTest
import SwiftUI
@testable import OversizeUI

class ButtonTests: XCTestCase {
    func testPrimaryButtonStyle() {
        let button = Button("Test") { }
            .buttonStyle(.primary)
        
        XCTAssertEqual(button.style, .primary)
    }
    
    func testButtonAccessibility() {
        let button = Button("Save Document") { }
        
        XCTAssertEqual(button.accessibilityLabel, "Save Document")
        XCTAssertTrue(button.isAccessibilityElement)
    }
}
```

### Preview Testing

```swift
// ✅ Test different states in previews
struct ButtonPreviews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: .medium) {
            Button("Normal") { }
                .buttonStyle(.primary)
            
            Button("Loading") { }
                .buttonStyle(.primary)
                .loading(true)
            
            Button("Disabled") { }
                .buttonStyle(.primary)
                .disabled(true)
        }
        .padding()
        .previewDisplayName("Button States")
    }
}
```

## Code Organization

### File Structure

```
Sources/MyApp/
├── Views/
│   ├── Profile/
│   │   ├── ProfileView.swift
│   │   ├── ProfileViewModel.swift
│   │   └── ProfileCard.swift
│   └── Settings/
│       ├── SettingsView.swift
│       └── SettingsRow.swift
├── Models/
│   ├── User.swift
│   └── AppError.swift
└── Services/
    ├── NetworkService.swift
    └── UserService.swift
```

### Naming Conventions

```swift
// ✅ Clear, descriptive names
struct UserProfileCard: View { }
struct SettingsToggleRow: View { }
struct LoadingIndicator: View { }

// ✅ Consistent modifier naming
extension View {
    func primaryAction() -> some View { }
    func cardStyle() -> some View { }
    func loadingState(_ isLoading: Bool) -> some View { }
}
```

## Common Patterns

### Loading States

```swift
// ✅ Consistent loading pattern
struct AsyncButton: View {
    @State private var isLoading = false
    let action: () async -> Void
    
    var body: some View {
        Button("Submit") {
            performAction()
        }
        .buttonStyle(.primary)
        .loading(isLoading)
        .disabled(isLoading)
    }
    
    private func performAction() {
        isLoading = true
        
        Task {
            await action()
            isLoading = false
        }
    }
}
```

### Navigation Patterns

```swift
// ✅ Consistent navigation
struct MainNavigationView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}
```

## Do's and Don'ts Summary

### Do's

- ✅ Use semantic component styles consistently
- ✅ Follow accessibility guidelines
- ✅ Provide meaningful error messages
- ✅ Test components with different states
- ✅ Use design system tokens for spacing and colors
- ✅ Clean up resources when views disappear
- ✅ Provide descriptive accessibility labels
- ✅ Use consistent naming conventions

### Don'ts

- ❌ Hardcode colors or spacing values
- ❌ Ignore accessibility requirements
- ❌ Use vague button labels or error messages
- ❌ Forget to handle loading and error states
- ❌ Skip testing with assistive technologies
- ❌ Overuse high elevation surfaces
- ❌ Rely solely on color to convey information
- ❌ Ignore platform conventions

## See Also

- <doc:Architecture>
- <doc:Accessibility>
- <doc:Theming>
- <doc:GettingStarted>
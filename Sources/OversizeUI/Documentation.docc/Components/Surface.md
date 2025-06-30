# Surface

A flexible container component that provides elevation, styling, and background treatment.

## Overview

The `Surface` component is the foundation for creating elevated content areas in OversizeUI. It provides consistent styling, elevation effects, and background treatment while maintaining accessibility and theme integration. Surface acts as a container that can hold any content while providing visual hierarchy through elevation and styling.

### When to Use Surface

- **Content Cards**: Display grouped content with visual separation
- **Modal Content**: Create elevated overlays and dialogs
- **Form Sections**: Group related form elements
- **Information Panels**: Present structured information
- **Navigation Elements**: Create elevated navigation containers

## Basic Usage

### Simple Surface

```swift
Surface {
    VStack {
        Text("Card Title")
            .headline()
        
        Text("Card content goes here with additional information.")
            .body()
    }
    .padding()
}
```

### Surface with Background

```swift
Surface {
    HStack {
        Icon(.info)
            .foregroundColor(.accent)
        
        Text("Important information")
            .body(.medium)
        
        Spacer()
    }
    .padding()
}
.background(.surfaceSecondary)
```

## Elevation and Styling

### Elevation Levels

Control visual hierarchy with elevation:

```swift
VStack(spacing: .medium) {
    // Base level - no elevation
    Surface {
        Text("Base Surface")
            .padding()
    }
    
    // Small elevation
    Surface {
        Text("Small Elevation")
            .padding()
    }
    .elevation(.small)
    
    // Medium elevation
    Surface {
        Text("Medium Elevation")
            .padding()
    }
    .elevation(.medium)
    
    // Large elevation
    Surface {
        Text("Large Elevation")
            .padding()
    }
    .elevation(.large)
}
```

### Custom Backgrounds

Apply different background treatments:

```swift
VStack(spacing: .medium) {
    // Primary surface background
    Surface {
        Text("Primary Surface")
            .padding()
    }
    .background(.surfacePrimary)
    
    // Secondary surface background
    Surface {
        Text("Secondary Surface")
            .padding()
    }
    .background(.surfaceSecondary)
    
    // Tertiary surface background
    Surface {
        Text("Tertiary Surface")
            .padding()
    }
    .background(.surfaceTertiary)
    
    // Custom color background
    Surface {
        Text("Custom Background")
            .foregroundColor(.white)
            .padding()
    }
    .background(.accent)
}
```

## Practical Examples

### Information Card

```swift
struct InfoCard: View {
    let title: String
    let description: String
    let icon: IconsNames
    
    var body: some View {
        Surface {
            HStack(spacing: .medium) {
                Icon(icon)
                    .foregroundColor(.accent)
                    .frame(width: 24, height: 24)
                
                VStack(alignment: .leading, spacing: .xSmall) {
                    Text(title)
                        .headline(.semibold)
                        .foregroundColor(.onSurfacePrimary)
                    
                    Text(description)
                        .body(.medium)
                        .foregroundColor(.onSurfaceSecondary)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
            }
            .padding()
        }
        .background(.surfacePrimary)
        .elevation(.small)
    }
}

// Usage
InfoCard(
    title: "Security",
    description: "Your data is encrypted and secure",
    icon: .shield
)
```

### Profile Card

```swift
struct ProfileCard: View {
    let user: User
    
    var body: some View {
        Surface {
            VStack(spacing: .medium) {
                Avatar(
                    firstName: user.firstName,
                    lastName: user.lastName,
                    avatar: user.profileImage
                )
                .controlSize(.large)
                .stroke(.accent, lineWidth: 2)
                
                VStack(spacing: .xSmall) {
                    Text(user.fullName)
                        .title3(.bold)
                        .foregroundColor(.onSurfacePrimary)
                    
                    Text(user.role)
                        .body(.medium)
                        .foregroundColor(.onSurfaceSecondary)
                    
                    Text(user.department)
                        .caption()
                        .foregroundColor(.onSurfaceTertiary)
                }
                
                HStack(spacing: .medium) {
                    Button("Message") {
                        sendMessage()
                    }
                    .buttonStyle(.secondary)
                    .controlSize(.small)
                    
                    Button("Call") {
                        makeCall()
                    }
                    .buttonStyle(.primary)
                    .controlSize(.small)
                }
            }
            .padding(.large)
        }
        .background(.surfacePrimary)
        .elevation(.medium)
    }
}
```

### Statistics Card

```swift
struct StatisticsCard: View {
    let title: String
    let value: String
    let change: Double
    let trend: TrendDirection
    
    enum TrendDirection {
        case up, down, neutral
    }
    
    var body: some View {
        Surface {
            VStack(alignment: .leading, spacing: .medium) {
                HStack {
                    Text(title)
                        .caption(.medium)
                        .foregroundColor(.onSurfaceSecondary)
                        .textCase(.uppercase)
                    
                    Spacer()
                    
                    trendIcon
                }
                
                Text(value)
                    .title(.bold)
                    .foregroundColor(.onSurfacePrimary)
                
                HStack {
                    Text(changeText)
                        .caption(.medium)
                        .foregroundColor(changeColor)
                    
                    Spacer()
                    
                    Text("vs last month")
                        .caption()
                        .foregroundColor(.onSurfaceTertiary)
                }
            }
            .padding()
        }
        .background(.surfacePrimary)
        .elevation(.small)
    }
    
    private var trendIcon: some View {
        Icon(trend == .up ? .arrowUp : trend == .down ? .arrowDown : .minus)
            .foregroundColor(changeColor)
            .font(.caption)
    }
    
    private var changeColor: Color {
        switch trend {
        case .up: return .success
        case .down: return .error
        case .neutral: return .onSurfaceSecondary
        }
    }
    
    private var changeText: String {
        let sign = trend == .up ? "+" : trend == .down ? "-" : ""
        return "\(sign)\(abs(change), specifier: "%.1f")%"
    }
}
```

### Modal Surface

```swift
struct ModalSurface<Content: View>: View {
    let content: Content
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            // Background overlay
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            // Modal content
            Surface {
                VStack(alignment: .trailing, spacing: .zero) {
                    // Close button
                    Button {
                        isPresented = false
                    } label: {
                        Icon(.xmark)
                    }
                    .buttonStyle(.quaternary)
                    .controlSize(.small)
                    
                    // Content
                    content
                        .padding(.top, .medium)
                }
                .padding()
            }
            .background(.surfaceTertiary)
            .elevation(.large)
            .cornerRadius(.large)
            .padding()
        }
    }
}

// Usage
@State private var showModal = false

Button("Show Modal") {
    showModal = true
}
.sheet(isPresented: $showModal) {
    ModalSurface(isPresented: $showModal) {
        VStack {
            Text("Modal Title")
                .title2()
            
            Text("Modal content goes here...")
                .body()
        }
    }
}
```

### Settings Panel

```swift
struct SettingsPanel: View {
    @State private var notifications = true
    @State private var darkMode = false
    @State private var autoSync = true
    
    var body: some View {
        Surface {
            VStack(spacing: .zero) {
                // Header
                HStack {
                    Text("Settings")
                        .title3(.bold)
                        .foregroundColor(.onSurfacePrimary)
                    
                    Spacer()
                }
                .padding(.bottom, .medium)
                
                // Settings options
                VStack(spacing: .small) {
                    SettingRow(
                        title: "Notifications",
                        description: "Receive push notifications",
                        isOn: $notifications
                    )
                    
                    SettingRow(
                        title: "Dark Mode",
                        description: "Use dark appearance",
                        isOn: $darkMode
                    )
                    
                    SettingRow(
                        title: "Auto Sync",
                        description: "Sync data automatically",
                        isOn: $autoSync
                    )
                }
            }
            .padding()
        }
        .background(.surfaceSecondary)
        .elevation(.medium)
    }
}

struct SettingRow: View {
    let title: String
    let description: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: .xxSmall) {
                Text(title)
                    .body(.medium)
                    .foregroundColor(.onSurfacePrimary)
                
                Text(description)
                    .caption()
                    .foregroundColor(.onSurfaceSecondary)
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
        }
        .padding(.vertical, .xSmall)
    }
}
```

## Accessibility

### Automatic Features

Surface components automatically provide:

- **Semantic Structure**: Proper grouping for screen readers
- **Focus Management**: Appropriate focus behavior for interactive surfaces
- **Container Semantics**: Clear content boundaries for assistive technologies

### Custom Accessibility

Enhance accessibility for complex surfaces:

```swift
Surface {
    VStack {
        Text("Card Title")
            .headline()
        
        Text("Important information about this topic.")
            .body()
    }
    .padding()
}
.accessibilityElement(children: .combine)
.accessibilityLabel("Information card: Card Title")
.accessibilityHint("Contains important information about this topic")
```

## Design Guidelines

### Elevation Hierarchy

Use elevation to create clear visual hierarchy:

1. **No Elevation**: Base content, main backgrounds
2. **Small Elevation**: Cards, list items, subtle separation
3. **Medium Elevation**: Important panels, active states
4. **Large Elevation**: Modals, overlays, temporary content

### Background Selection

Choose backgrounds that support content hierarchy:

- **Primary Surface**: Main content areas, default cards
- **Secondary Surface**: Elevated content, nested containers
- **Tertiary Surface**: Highest elevation, modals, overlays

### Do's and Don'ts

#### Do's

- ✅ Use consistent elevation levels throughout your app
- ✅ Ensure sufficient contrast between surface and content
- ✅ Group related content within surfaces
- ✅ Use elevation to guide user attention
- ✅ Test surfaces in both light and dark modes

#### Don'ts

- ❌ Don't overuse high elevation levels
- ❌ Don't nest surfaces with the same elevation
- ❌ Don't use surfaces for purely decorative purposes
- ❌ Don't ignore touch target sizes on interactive surfaces
- ❌ Don't use elevation as the only visual separator

## API Reference

### Surface Initializer

```swift
Surface(@ViewBuilder content: () -> Content)
```

### Common Modifiers

```swift
// Background styling
func background(_ background: some ShapeStyle) -> some View

// Elevation
func elevation(_ level: Elevation) -> some View

// Corner radius
func cornerRadius(_ radius: CGFloat) -> some View

// Shadow (part of elevation system)
func shadow(_ shadow: ShadowStyle) -> some View
```

### Elevation Levels

```swift
enum Elevation {
    case none    // No shadow
    case small   // Subtle elevation
    case medium  // Standard elevation
    case large   // High elevation
}
```

## See Also

- ``Button``
- ``SectionView``
- ``Row``
- <doc:DesignSystem/Colors>
- <doc:Architecture>
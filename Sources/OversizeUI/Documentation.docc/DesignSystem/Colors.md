# Colors

A semantic color system that adapts to light and dark themes while maintaining accessibility standards.

## Overview

OversizeUI's color system provides a comprehensive palette of semantic colors that automatically adapt to system appearance changes. The color system is built on accessibility principles, ensuring proper contrast ratios and meaningful color relationships across all platforms and themes.

### Design Principles

- **Semantic Naming**: Colors convey meaning and purpose, not appearance
- **Automatic Adaptation**: Seamless light and dark mode support
- **Accessibility First**: WCAG 2.1 AA compliance with 4.5:1 contrast ratios
- **Platform Consistency**: Follows platform conventions while maintaining brand identity
- **Extensible**: Easy to customize and extend with brand colors

## Color Categories

### Primary Colors

The main brand colors and accent colors:

```swift
// Primary accent color (customizable)
Color.accent

// Primary brand color
Color.primary
```

### Surface Colors

Background colors that create visual hierarchy:

```swift
// Primary surface - main background
Color.backgroundPrimary

// Secondary surface - elevated content
Color.backgroundSecondary  

// Tertiary surface - highest elevation
Color.backgroundTertiary

// Surface colors for components
Color.surfacePrimary      // Default surface
Color.surfaceSecondary    // Elevated surface
Color.surfaceTertiary     // Highest elevation
```

### Content Colors

Text and content colors with proper contrast:

```swift
// High emphasis text
Color.onSurfacePrimary

// Medium emphasis text  
Color.onSurfaceSecondary

// Low emphasis text
Color.onSurfaceTertiary

// Disabled text
Color.onSurfaceDisabled
```

### Interactive Colors

Colors for interactive elements:

```swift
// Default button and link color
Color.accent

// Success states
Color.success

// Warning states  
Color.warning

// Error states
Color.error

// Information states
Color.info
```

### Border Colors

Subtle borders and dividers:

```swift
// Primary borders
Color.border

// Secondary borders (lighter)
Color.borderSecondary

// Tertiary borders (lightest)
Color.borderTertiary
```

## Practical Usage

### Text Hierarchy

Use semantic colors to create clear content hierarchy:

```swift
VStack(alignment: .leading, spacing: .medium) {
    Text("Primary Title")
        .title2(.bold)
        .foregroundColor(.onSurfacePrimary)
    
    Text("Secondary subtitle with important information")
        .body(.medium)
        .foregroundColor(.onSurfaceSecondary)
    
    Text("Supporting text and additional details")
        .caption()
        .foregroundColor(.onSurfaceTertiary)
    
    Text("Disabled or inactive text")
        .footnote()
        .foregroundColor(.onSurfaceDisabled)
}
```

### Surface Hierarchy

Create depth and elevation with surface colors:

```swift
VStack(spacing: .medium) {
    // Primary background
    Surface {
        Text("Main Content Area")
            .padding()
    }
    .background(.backgroundPrimary)
    
    // Elevated surface
    Surface {
        Text("Elevated Card")
            .padding()
    }
    .background(.backgroundSecondary)
    .elevation(.medium)
    
    // Highest elevation
    Surface {
        Text("Modal or Overlay")
            .padding()
    }
    .background(.backgroundTertiary)
    .elevation(.high)
}
```

### State Colors

Communicate different states effectively:

```swift
// Success state
NoticeView("Operation completed successfully!")
    .foregroundColor(.success)
    .background(.success.opacity(0.1))

// Warning state  
NoticeView("Please review the following items")
    .foregroundColor(.warning)
    .background(.warning.opacity(0.1))

// Error state
NoticeView("An error occurred. Please try again.")
    .foregroundColor(.error)
    .background(.error.opacity(0.1))

// Info state
NoticeView("New features are available in settings")
    .foregroundColor(.info)
    .background(.info.opacity(0.1))
```

## Dark Mode Adaptation

All colors automatically adapt to dark mode:

```swift
struct AdaptiveInterface: View {
    var body: some View {
        VStack {
            Text("This text maintains proper contrast")
                .foregroundColor(.onSurfacePrimary) // Black in light, white in dark
            
            Text("Secondary text adapts too")
                .foregroundColor(.onSurfaceSecondary) // Dark gray in light, light gray in dark
        }
        .padding()
        .background(.surfacePrimary) // White in light, dark gray in dark
        .cornerRadius(.medium)
    }
}
```

### Custom Dark Mode Colors

Define custom colors that adapt to appearance:

```swift
extension Color {
    static var customBrand: Color {
        Color("CustomBrand", bundle: .main)
    }
    
    // In your color set:
    // Light mode: #007AFF
    // Dark mode: #0A84FF
}
```

## Accessibility Considerations

### Contrast Ratios

All color combinations meet accessibility standards:

```swift
// ✅ High contrast combinations
Text("Primary text")
    .foregroundColor(.onSurfacePrimary) // 21:1 contrast ratio

Text("Secondary text")  
    .foregroundColor(.onSurfaceSecondary) // 7:1 contrast ratio

Text("Tertiary text")
    .foregroundColor(.onSurfaceTertiary) // 4.5:1 contrast ratio

// ❌ Avoid low contrast
Text("Hard to read")
    .foregroundColor(.onSurfaceDisabled) // Only for disabled states
```

### Color Independence

Never rely solely on color to convey information:

```swift
// ✅ Good: Color + icon + text
HStack {
    Icon(.checkmark)
        .foregroundColor(.success)
    Text("Success")
        .foregroundColor(.success)
}

// ✅ Good: Color + shape + text  
HStack {
    Circle()
        .fill(.error)
        .frame(width: 8, height: 8)
    Text("Error occurred")
}

// ❌ Bad: Color only
Text("Important")
    .foregroundColor(.error) // Color alone doesn't convey importance
```

## Theme Integration

### Using Theme Settings

Access and customize colors through theme settings:

```swift
struct ThemedView: View {
    @Environment(\.theme) private var theme: ThemeSettings
    
    var body: some View {
        VStack {
            Text("Themed Content")
                .foregroundColor(theme.accentColor)
            
            Button("Action") {
                // Action
            }
            .accent(theme.accentColor)
        }
    }
}
```

### Custom Color Schemes

Create custom color schemes:

```swift
extension ThemeSettings {
    static var oceanTheme: ThemeSettings {
        let theme = ThemeSettings()
        theme.accentColor = Color(red: 0.0, green: 0.5, blue: 0.8)
        return theme
    }
    
    static var forestTheme: ThemeSettings {
        let theme = ThemeSettings()
        theme.accentColor = Color(red: 0.2, green: 0.6, blue: 0.2)
        return theme
    }
}
```

## Practical Examples

### Status Indicators

```swift
struct StatusIndicator: View {
    enum Status {
        case online, away, busy, offline
    }
    
    let status: Status
    
    var body: some View {
        HStack(spacing: .small) {
            Circle()
                .fill(statusColor)
                .frame(width: 8, height: 8)
            
            Text(statusText)
                .caption(.medium)
                .foregroundColor(.onSurfaceSecondary)
        }
    }
    
    private var statusColor: Color {
        switch status {
        case .online: return .success
        case .away: return .warning
        case .busy: return .error
        case .offline: return .onSurfaceDisabled
        }
    }
    
    private var statusText: String {
        switch status {
        case .online: return "Online"
        case .away: return "Away"
        case .busy: return "Busy"
        case .offline: return "Offline"
        }
    }
}
```

### Progress Indicators

```swift
struct ProgressCard: View {
    let progress: Double
    let title: String
    
    var body: some View {
        Surface {
            VStack(alignment: .leading, spacing: .medium) {
                Text(title)
                    .headline()
                    .foregroundColor(.onSurfacePrimary)
                
                VStack(alignment: .leading, spacing: .small) {
                    HStack {
                        Text("\(Int(progress * 100))%")
                            .caption(.bold)
                            .foregroundColor(.accent)
                        
                        Spacer()
                        
                        Text("Complete")
                            .caption()
                            .foregroundColor(.onSurfaceSecondary)
                    }
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(.borderSecondary)
                                .frame(height: 4)
                            
                            Rectangle()
                                .fill(.accent)
                                .frame(width: geometry.size.width * progress, height: 4)
                        }
                    }
                    .frame(height: 4)
                }
            }
            .padding()
        }
        .background(.surfacePrimary)
    }
}
```

### Alert Banners

```swift
struct AlertBanner: View {
    enum AlertType {
        case success, warning, error, info
    }
    
    let type: AlertType
    let message: String
    
    var body: some View {
        HStack(spacing: .medium) {
            Icon(alertIcon)
                .foregroundColor(alertColor)
            
            Text(message)
                .body(.medium)
                .foregroundColor(.onSurfacePrimary)
            
            Spacer()
        }
        .padding()
        .background(alertColor.opacity(0.1))
        .overlay(
            Rectangle()
                .frame(width: 4)
                .foregroundColor(alertColor),
            alignment: .leading
        )
        .cornerRadius(.medium)
    }
    
    private var alertColor: Color {
        switch type {
        case .success: return .success
        case .warning: return .warning
        case .error: return .error
        case .info: return .info
        }
    }
    
    private var alertIcon: IconsNames {
        switch type {
        case .success: return .checkmark
        case .warning: return .exclamationmark
        case .error: return .xmark
        case .info: return .info
        }
    }
}
```

## Design Guidelines

### Do's

- ✅ Use semantic color names for maintainability
- ✅ Test colors in both light and dark modes
- ✅ Ensure sufficient contrast for all text
- ✅ Use color consistently throughout your app
- ✅ Provide alternative indicators beyond color
- ✅ Consider color blindness when designing

### Don'ts

- ❌ Don't hardcode color values in components
- ❌ Don't use pure black or white for text
- ❌ Don't rely solely on color to convey meaning
- ❌ Don't ignore accessibility contrast requirements
- ❌ Don't use too many accent colors
- ❌ Don't forget to test with high contrast settings

## API Reference

### Semantic Colors

```swift
// Background colors
static var backgroundPrimary: Color
static var backgroundSecondary: Color
static var backgroundTertiary: Color

// Surface colors
static var surfacePrimary: Color
static var surfaceSecondary: Color
static var surfaceTertiary: Color

// Content colors
static var onSurfacePrimary: Color
static var onSurfaceSecondary: Color
static var onSurfaceTertiary: Color
static var onSurfaceDisabled: Color

// Interactive colors
static var accent: Color
static var primary: Color

// State colors
static var success: Color
static var warning: Color
static var error: Color
static var info: Color

// Border colors
static var border: Color
static var borderSecondary: Color
static var borderTertiary: Color
```

### Theme Integration

```swift
// Environment theme access
@Environment(\.theme) private var theme: ThemeSettings

// Theme color properties
theme.accentColor: Color
theme.appearance: Appearance // .light, .dark, .system
```

## See Also

- <doc:Typography>
- <doc:Spacing>
- <doc:Theming>
- <doc:Accessibility>
- ``Surface``
- ``Button``
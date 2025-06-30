# Theming

Customize OversizeUI's appearance to match your brand while maintaining accessibility and usability.

## Overview

OversizeUI's theming system provides extensive customization options while preserving the design system's consistency and accessibility features. The theme system is built around semantic tokens that automatically adapt to different platforms and user preferences.

### Theme Architecture

The theming system is built on three core concepts:

1. **Design Tokens**: Fundamental design decisions (colors, spacing, typography)
2. **Semantic Mapping**: Tokens mapped to meaningful component properties
3. **Context Adaptation**: Automatic adaptation to platform and user preferences

## Getting Started with Themes

### Basic Theme Setup

Set up theming in your app's root:

```swift
@main
struct MyApp: App {
    @StateObject private var theme = ThemeSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(theme)
        }
    }
}
```

### Accessing Theme in Components

```swift
struct ThemedComponent: View {
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
        .background(theme.surfaceColor)
    }
}
```

## Customizing Colors

### Accent Colors

Define your brand's primary accent color:

```swift
extension ThemeSettings {
    static var brandTheme: ThemeSettings {
        let theme = ThemeSettings()
        theme.accentColor = Color(red: 0.2, green: 0.6, blue: 0.8)
        return theme
    }
}

// Apply in your app
@StateObject private var theme = ThemeSettings.brandTheme
```

### Custom Color Palettes

Create comprehensive color schemes:

```swift
extension Color {
    // Brand colors
    static var brandPrimary: Color {
        Color("BrandPrimary", bundle: .main)
    }
    
    static var brandSecondary: Color {
        Color("BrandSecondary", bundle: .main)
    }
    
    static var brandTertiary: Color {
        Color("BrandTertiary", bundle: .main)
    }
}

// Use in custom theme
extension ThemeSettings {
    static var customBrandTheme: ThemeSettings {
        let theme = ThemeSettings()
        theme.accentColor = .brandPrimary
        // Additional customizations
        return theme
    }
}
```

### Dark Mode Considerations

Ensure your colors work in both light and dark modes:

```swift
// In your color set assets:
// Light Appearance: #007AFF
// Dark Appearance: #0A84FF

extension Color {
    static var adaptiveBrand: Color {
        Color("AdaptiveBrand", bundle: .main)
    }
}

struct ThemedView: View {
    var body: some View {
        Text("Adaptive text")
            .foregroundColor(.adaptiveBrand) // Automatically adapts
            .background(.surfacePrimary) // System adaptive background
    }
}
```

## Typography Customization

### Custom Font Families

Integrate custom fonts with the typography system:

```swift
extension ThemeSettings {
    static var customFontTheme: ThemeSettings {
        let theme = ThemeSettings()
        theme.fontTitle = .custom("YourCustomFont-Bold")
        theme.fontParagraph = .custom("YourCustomFont-Regular")
        theme.fontButton = .custom("YourCustomFont-Semibold")
        return theme
    }
}
```

### Font Design Types

Choose system font designs:

```swift
extension ThemeSettings {
    static var roundedTheme: ThemeSettings {
        let theme = ThemeSettings()
        theme.fontTitle = .rounded
        theme.fontParagraph = .rounded
        return theme
    }
    
    static var serifTheme: ThemeSettings {
        let theme = ThemeSettings()
        theme.fontTitle = .serif
        theme.fontParagraph = .serif
        return theme
    }
}
```

## Layout and Spacing

### Border Radius Customization

Adjust corner radius to match your design language:

```swift
extension ThemeSettings {
    static var roundedTheme: ThemeSettings {
        let theme = ThemeSettings()
        theme.radius = 12 // More rounded
        return theme
    }
    
    static var squareTheme: ThemeSettings {
        let theme = ThemeSettings()
        theme.radius = 4 // Less rounded
        return theme
    }
}
```

### Border Styles

Control border appearance across components:

```swift
extension ThemeSettings {
    static var borderedTheme: ThemeSettings {
        let theme = ThemeSettings()
        theme.borderButtons = true
        theme.borderTextFields = true
        theme.borderSurface = true
        theme.borderSize = 1.0
        return theme
    }
}
```

## Component-Specific Theming

### Button Theming

Create custom button styles that integrate with the theme system:

```swift
struct BrandButtonStyle: ButtonStyle {
    @Environment(\.theme) private var theme: ThemeSettings
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(theme.accentColor)
            .foregroundColor(.white)
            .cornerRadius(theme.radius)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

extension ButtonStyle where Self == BrandButtonStyle {
    static var brand: BrandButtonStyle {
        BrandButtonStyle()
    }
}

// Usage
Button("Brand Action") {
    // Action
}
.buttonStyle(.brand)
```

### Surface Theming

Customize surface appearance:

```swift
struct CustomSurface<Content: View>: View {
    @Environment(\.theme) private var theme: ThemeSettings
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(.surfacePrimary)
            .cornerRadius(theme.radius)
            .overlay(
                RoundedRectangle(cornerRadius: theme.radius)
                    .stroke(.borderPrimary, lineWidth: theme.borderSurface ? theme.borderSize : 0)
            )
    }
}
```

## Advanced Theming Examples

### Multi-Brand Theme Support

Support multiple brands within the same application:

```swift
enum BrandIdentity: CaseIterable {
    case primary, secondary, partner
    
    var theme: ThemeSettings {
        switch self {
        case .primary:
            return .primaryBrandTheme
        case .secondary:
            return .secondaryBrandTheme
        case .partner:
            return .partnerBrandTheme
        }
    }
}

struct MultiBrandView: View {
    @State private var selectedBrand: BrandIdentity = .primary
    
    var body: some View {
        VStack {
            Picker("Brand", selection: $selectedBrand) {
                ForEach(BrandIdentity.allCases, id: \.self) { brand in
                    Text(String(describing: brand).capitalized)
                }
            }
            .pickerStyle(.segmented)
            
            ContentView()
                .environmentObject(selectedBrand.theme)
        }
    }
}
```

### Theme Persistence

Save and restore user theme preferences:

```swift
class ThemeManager: ObservableObject {
    @Published var currentTheme: ThemeSettings
    
    init() {
        if let savedThemeData = UserDefaults.standard.data(forKey: "SavedTheme"),
           let savedTheme = try? JSONDecoder().decode(ThemeSettings.self, from: savedThemeData) {
            currentTheme = savedTheme
        } else {
            currentTheme = ThemeSettings()
        }
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(currentTheme) {
            UserDefaults.standard.set(encoded, forKey: "SavedTheme")
        }
    }
    
    func applyTheme(_ theme: ThemeSettings) {
        currentTheme = theme
        save()
    }
}
```

### Theme Animation

Animate theme transitions smoothly:

```swift
struct AnimatedThemeView: View {
    @StateObject private var themeManager = ThemeManager()
    
    var body: some View {
        ContentView()
            .environmentObject(themeManager.currentTheme)
            .animation(.easeInOut(duration: 0.3), value: themeManager.currentTheme.accentColor)
            .animation(.easeInOut(duration: 0.3), value: themeManager.currentTheme.radius)
    }
}
```

## Theme Validation

### Accessibility Compliance

Ensure custom themes maintain accessibility standards:

```swift
extension ThemeSettings {
    var isAccessibilityCompliant: Bool {
        // Check contrast ratios
        let contrastRatio = calculateContrastRatio(
            foreground: accentColor,
            background: .surfacePrimary
        )
        
        return contrastRatio >= 4.5 // WCAG AA compliance
    }
    
    func validateTheme() -> [String] {
        var issues: [String] = []
        
        if !isAccessibilityCompliant {
            issues.append("Accent color doesn't meet contrast requirements")
        }
        
        if radius < 0 || radius > 20 {
            issues.append("Border radius should be between 0 and 20")
        }
        
        return issues
    }
}
```

### Theme Testing

Test themes across different conditions:

```swift
struct ThemeTestView: View {
    let theme: ThemeSettings
    
    var body: some View {
        VStack(spacing: .large) {
            // Test all component styles
            componentTests
            
            // Test in different color schemes
            Group {
                componentTests
                    .preferredColorScheme(.light)
                    .background(.gray.opacity(0.1))
                
                componentTests
                    .preferredColorScheme(.dark)
                    .background(.gray.opacity(0.9))
            }
        }
        .environmentObject(theme)
    }
    
    private var componentTests: some View {
        VStack {
            Button("Primary") { }
                .buttonStyle(.primary)
            
            Button("Secondary") { }
                .buttonStyle(.secondary)
            
            TextField("Test input", text: .constant(""))
                .textFieldStyle(.default)
            
            Surface {
                Text("Surface content")
                    .padding()
            }
        }
    }
}
```

## Theme Documentation

### Design System Documentation

Document your custom themes:

```swift
/// Corporate theme following brand guidelines.
///
/// This theme uses the company's primary brand colors and typography
/// to create a cohesive visual experience across all platforms.
///
/// ## Colors
/// - Primary: Corporate Blue (#1565C0)
/// - Secondary: Corporate Gray (#424242)
/// - Accent: Corporate Orange (#FF9800)
///
/// ## Typography
/// - Headers: Corporate Sans Bold
/// - Body: Corporate Sans Regular
/// - UI: System fonts for platform consistency
///
/// ## Usage
/// ```swift
/// @StateObject private var theme = ThemeSettings.corporateTheme
/// 
/// WindowGroup {
///     ContentView()
///         .environmentObject(theme)
/// }
/// ```
extension ThemeSettings {
    static var corporateTheme: ThemeSettings {
        let theme = ThemeSettings()
        theme.accentColor = Color(red: 0.08, green: 0.40, blue: 0.75)
        theme.fontTitle = .custom("CorporateSans-Bold")
        theme.fontParagraph = .custom("CorporateSans-Regular")
        theme.radius = 8
        theme.borderButtons = true
        return theme
    }
}
```

## Platform Adaptations

### iOS Theming

iOS-specific theme considerations:

```swift
extension ThemeSettings {
    static var iOSTheme: ThemeSettings {
        let theme = ThemeSettings()
        #if os(iOS)
        theme.borderButtons = false // iOS prefers borderless buttons
        theme.radius = 8 // iOS standard corner radius
        #endif
        return theme
    }
}
```

### macOS Theming

macOS-specific theme adaptations:

```swift
extension ThemeSettings {
    static var macOSTheme: ThemeSettings {
        let theme = ThemeSettings()
        #if os(macOS)
        theme.borderButtons = true // macOS benefits from borders
        theme.borderSize = 0.5 // Subtle borders
        theme.radius = 6 // Slightly less rounded than iOS
        #endif
        return theme
    }
}
```

## Migration and Updates

### Theme Version Management

Handle theme updates gracefully:

```swift
struct ThemeVersion {
    static let current = "3.0"
    
    static func migrateTheme(_ theme: ThemeSettings, from version: String) -> ThemeSettings {
        switch version {
        case "2.0":
            // Migrate from version 2.0
            return migrateFromV2(theme)
        case "1.0":
            // Migrate from version 1.0
            return migrateFromV1(theme)
        default:
            return theme
        }
    }
}
```

### Backward Compatibility

Maintain compatibility with older theme versions:

```swift
extension ThemeSettings {
    // Legacy property support
    @available(*, deprecated, message: "Use accentColor instead")
    var primaryColor: Color {
        get { accentColor }
        set { accentColor = newValue }
    }
}
```

## Best Practices

### Do's

- ✅ Test themes with accessibility tools
- ✅ Provide light and dark variants for custom colors
- ✅ Use semantic naming for theme properties
- ✅ Validate contrast ratios for accessibility compliance
- ✅ Document theme usage and guidelines
- ✅ Test themes across all supported platforms

### Don'ts

- ❌ Don't hardcode colors outside the theme system
- ❌ Don't ignore platform conventions
- ❌ Don't sacrifice accessibility for visual appeal
- ❌ Don't create too many theme variations
- ❌ Don't forget to test edge cases (large text, high contrast)

## See Also

- <doc:Colors>
- <doc:Typography>
- <doc:Accessibility>
- <doc:Architecture>
- ``ThemeSettings``
- ``Surface``
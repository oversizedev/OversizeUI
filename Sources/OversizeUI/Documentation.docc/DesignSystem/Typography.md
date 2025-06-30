# Typography

A comprehensive typography system that provides consistent text styling across all platforms.

## Overview

OversizeUI's typography system provides a semantic approach to text styling that automatically adapts to platform conventions and user preferences. Built on SwiftUI's native text system, it extends functionality with design system integration, automatic accessibility support, and consistent visual hierarchy.

### Design Principles

- **Semantic Hierarchy**: Typography styles convey meaning and importance
- **Platform Adaptive**: Automatically adapts to iOS, macOS, tvOS, and watchOS conventions
- **Accessibility First**: Full Dynamic Type support with automatic scaling
- **Design System Integration**: Consistent with spacing, colors, and overall design language

## Typography Scale

### Display Text

Use for the largest, most prominent text on screen:

```swift
Text("Welcome")
    .largeTitle()
    .foregroundColor(.onSurfacePrimary)
```

### Titles

Create clear content hierarchy with title styles:

```swift
// Title - Large section headers
Text("Settings")
    .title()

// Title 2 - Medium section headers  
Text("Account")
    .title2()

// Title 3 - Small section headers
Text("Privacy")
    .title3()
```

### Headlines and Subheadings

Emphasize important content:

```swift
// Headline - Emphasized content
Text("Important Notice")
    .headline()

// Subheadline - Supporting headers
Text("Additional Information")
    .subheadline()
```

### Body Text

For regular content and reading:

```swift
// Body - Primary reading text
Text("This is the main content of your application...")
    .body()

// Callout - Slightly emphasized body text
Text("This information is important to note.")
    .callout()
```

### Supporting Text

For secondary information:

```swift
// Footnote - Legal text, disclaimers
Text("Terms and conditions apply")
    .footnote()

// Caption - Image captions, metadata
Text("Photo taken on iPhone")
    .caption()

// Caption 2 - Smallest text
Text("© 2024")
    .caption2()
```

## Font Weights

All typography styles support font weight variations:

```swift
// Using weight parameter
Text("Bold Title")
    .title(.bold)

Text("Semibold Headline")
    .headline(.semibold)

Text("Medium Body")
    .body(.medium)

// Using boolean parameter for common weights
Text("Bold Text")
    .body(true) // Bold

Text("Regular Text")
    .body(false) // Regular
```

### Available Weights

```swift
Text("Ultra Light").body(.ultraLight)
Text("Thin").body(.thin)
Text("Light").body(.light)
Text("Regular").body(.regular)
Text("Medium").body(.medium)
Text("Semibold").body(.semibold)
Text("Bold").body(.bold)
Text("Heavy").body(.heavy)
Text("Black").body(.black)
```

## Practical Examples

### Article Layout

```swift
struct ArticleView: View {
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .large) {
                // Article header
                VStack(alignment: .leading, spacing: .medium) {
                    Text(article.category)
                        .caption(.medium)
                        .foregroundColor(.onSurfaceSecondary)
                        .textCase(.uppercase)
                    
                    Text(article.title)
                        .largeTitle(.bold)
                        .foregroundColor(.onSurfacePrimary)
                    
                    Text(article.subtitle)
                        .title3(.medium)
                        .foregroundColor(.onSurfaceSecondary)
                    
                    HStack {
                        Text("By \(article.author)")
                            .body(.medium)
                        
                        Spacer()
                        
                        Text(article.publishDate)
                            .caption()
                            .foregroundColor(.onSurfaceTertiary)
                    }
                }
                
                Divider()
                
                // Article content
                VStack(alignment: .leading, spacing: .medium) {
                    ForEach(article.paragraphs, id: \.self) { paragraph in
                        Text(paragraph)
                            .body()
                            .lineSpacing(4)
                    }
                }
            }
            .padding()
        }
    }
}
```

### Settings Screen

```swift
struct SettingsView: View {
    var body: some View {
        List {
            Section {
                // Profile section
                SectionView("Profile") {
                    VStack(alignment: .leading, spacing: .small) {
                        Text("John Doe")
                            .headline()
                        
                        Text("john.doe@example.com")
                            .body(.medium)
                            .foregroundColor(.onSurfaceSecondary)
                        
                        Text("Member since 2021")
                            .caption()
                            .foregroundColor(.onSurfaceTertiary)
                    }
                }
            }
            
            Section {
                // Settings options
                Row("Notifications") {
                    Text("Enabled")
                        .caption(.medium)
                        .foregroundColor(.accent)
                }
                
                Row("Privacy") {
                    Text("Review Settings")
                        .caption()
                        .foregroundColor(.onSurfaceSecondary)
                }
            }
            
            Section {
                // Legal section
                VStack(alignment: .leading, spacing: .xSmall) {
                    Text("Legal")
                        .headline()
                    
                    Text("By using this app, you agree to our Terms of Service and Privacy Policy.")
                        .footnote()
                        .foregroundColor(.onSurfaceTertiary)
                }
                .padding(.vertical, .small)
            }
        }
        .navigationTitle("Settings")
    }
}
```

### Card Layout

```swift
struct ProductCard: View {
    let product: Product
    
    var body: some View {
        Surface {
            VStack(alignment: .leading, spacing: .medium) {
                // Product image
                AsyncImage(url: product.imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(.surfaceSecondary)
                }
                .frame(height: 200)
                .clipped()
                
                VStack(alignment: .leading, spacing: .small) {
                    // Product info
                    Text(product.category)
                        .caption(.medium)
                        .foregroundColor(.onSurfaceSecondary)
                        .textCase(.uppercase)
                    
                    Text(product.name)
                        .headline(.semibold)
                        .lineLimit(2)
                    
                    Text(product.description)
                        .body()
                        .foregroundColor(.onSurfaceSecondary)
                        .lineLimit(3)
                    
                    HStack {
                        Text(product.formattedPrice)
                            .title2(.bold)
                            .foregroundColor(.accent)
                        
                        Spacer()
                        
                        if product.isOnSale {
                            Text("ON SALE")
                                .caption(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, .small)
                                .padding(.vertical, .xxSmall)
                                .background(.accent)
                                .cornerRadius(.small)
                        }
                    }
                }
                .padding()
            }
        }
        .elevation(.small)
    }
}
```

## Dynamic Type Support

OversizeUI typography automatically supports Dynamic Type:

```swift
struct AccessibleText: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .medium) {
            Text("This text scales with system settings")
                .body()
            
            Text("Large accessibility sizes are supported")
                .caption()
                .foregroundColor(.onSurfaceSecondary)
        }
        // Automatically scales from XS to AX5 sizes
        .padding()
    }
}
```

### Custom Scaling Limits

Control scaling for specific content:

```swift
Text("Fixed size text")
    .body()
    .dynamicTypeSize(.large) // Limit maximum size

Text("Minimum readable size")
    .caption()
    .dynamicTypeSize(.small...(.accessibility3)) // Set range
```

## Custom Font Integration

### Using Custom Fonts

Integrate custom fonts with the typography system:

```swift
// Configure custom fonts in theme settings
@State private var theme = ThemeSettings()

// Apply custom font family
Text("Custom Font Text")
    .body()
    .font(theme.bodyFont) // Uses custom font if configured
```

### Font Design Types

Choose from different font designs:

```swift
// System font designs
Text("Rounded Design")
    .body()
    .fontDesign(.rounded)

Text("Monospaced Design")
    .body()
    .fontDesign(.monospaced)

Text("Serif Design")
    .body()
    .fontDesign(.serif)
```

## Accessibility Guidelines

### Do's

- ✅ Use semantic typography styles for proper hierarchy
- ✅ Ensure sufficient color contrast (4.5:1 minimum)
- ✅ Test with various Dynamic Type sizes
- ✅ Use meaningful text that can be read by VoiceOver
- ✅ Limit line length for better readability (45-75 characters)

### Don'ts

- ❌ Don't use typography purely for visual effect
- ❌ Don't disable Dynamic Type without good reason
- ❌ Don't rely solely on font size to convey information
- ❌ Don't use too many different typography styles in one view
- ❌ Don't forget to test with larger accessibility font sizes

## Typography Hierarchy Guidelines

### Information Architecture

1. **Large Title**: App name, main screen titles
2. **Title**: Primary section headers
3. **Title 2**: Secondary section headers
4. **Title 3**: Subsection headers
5. **Headline**: Emphasized content, card titles
6. **Subheadline**: Supporting headers
7. **Body**: Primary reading text
8. **Callout**: Emphasized body text
9. **Footnote**: Legal text, disclaimers
10. **Caption**: Metadata, image captions
11. **Caption 2**: Smallest supporting text

### Visual Weight Distribution

- **Heavy (Large Title, Title)**: 10% of text
- **Medium (Title 2, Title 3, Headline)**: 20% of text  
- **Regular (Body, Callout)**: 60% of text
- **Light (Caption, Footnote)**: 10% of text

## API Reference

### Typography Modifiers

```swift
// Title styles
func largeTitle(_ weight: Font.Weight = .regular) -> some View
func largeTitle(_ bold: Bool = true) -> some View
func title(_ weight: Font.Weight = .regular) -> some View
func title(_ bold: Bool = true) -> some View
func title2(_ weight: Font.Weight = .regular) -> some View
func title2(_ bold: Bool = true) -> some View
func title3(_ weight: Font.Weight = .regular) -> some View
func title3(_ bold: Bool = true) -> some View

// Content styles
func headline(_ weight: Font.Weight = .regular) -> some View
func headline(_ bold: Bool = true) -> some View
func subheadline(_ weight: Font.Weight = .regular) -> some View
func subheadline(_ bold: Bool = false) -> some View
func body(_ weight: Font.Weight = .regular) -> some View
func body(_ bold: Bool = false) -> some View
func callout(_ weight: Font.Weight = .regular) -> some View
func callout(_ bold: Bool = false) -> some View

// Supporting styles
func footnote(_ weight: Font.Weight = .regular) -> some View
func footnote(_ bold: Bool = false) -> some View
func caption(_ weight: Font.Weight = .regular) -> some View
func caption(_ bold: Bool = false) -> some View
func caption2(_ weight: Font.Weight = .regular) -> some View
func caption2(_ bold: Bool = false) -> some View
```

## See Also

- <doc:Colors>
- <doc:Spacing>
- <doc:Accessibility>
- ``Text``
- ``Button``
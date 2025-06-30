# ColorSelector

An intuitive color picker component with multiple display styles.

## Overview

The `ColorSelector` component provides an elegant way for users to select colors from predefined palettes. It supports multiple display styles and integrates seamlessly with the theme system while maintaining accessibility standards.

## Basic Usage

### Grid Style Color Selector

```swift
@State private var selectedColor = Color.blue

ColorSelector(selection: $selectedColor)
    .colorSelectorStyle(.grid)
```

### Palette Style Color Selector

```swift
@State private var selectedColor = Color.blue

ColorSelector(selection: $selectedColor)
    .colorSelectorStyle(.palette)
```

## Customization

### Control Size

```swift
ColorSelector(selection: $selectedColor)
    .colorSelectorStyle(.grid)
    .controlSize(.large)
```

### Custom Colors

```swift
let customColors: [Color] = [.red, .blue, .green, .yellow]

ColorSelector(colors: customColors, selection: $selectedColor)
    .colorSelectorStyle(.grid)
```

## Practical Examples

### Theme Selector

```swift
struct ThemeSelector: View {
    @State private var accentColor = Color.blue
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Accent Color")
                .headline()
            
            ColorSelector(selection: $accentColor)
                .colorSelectorStyle(.grid)
                .onChange(of: accentColor) { newColor in
                    updateTheme(accentColor: newColor)
                }
        }
    }
}
```

### Color Preferences

```swift
struct ColorPreferences: View {
    @State private var backgroundColor = Color.white
    @State private var textColor = Color.black
    
    var body: some View {
        Form {
            Section("Appearance") {
                VStack(alignment: .leading) {
                    Text("Background Color")
                        .body(.medium)
                    
                    ColorSelector(selection: $backgroundColor)
                        .colorSelectorStyle(.palette)
                }
                
                VStack(alignment: .leading) {
                    Text("Text Color")
                        .body(.medium)
                    
                    ColorSelector(selection: $textColor)
                        .colorSelectorStyle(.grid)
                }
            }
        }
    }
}
```

## Accessibility

ColorSelector automatically provides:

- VoiceOver support with color descriptions
- Proper focus management
- Semantic labeling

```swift
ColorSelector(selection: $color)
    .accessibilityLabel("Color selection")
    .accessibilityHint("Choose a color from the available options")
```

## API Reference

### Initializers

```swift
ColorSelector(selection: Binding<Color>)
ColorSelector(colors: [Color], selection: Binding<Color>)
```

### Styles

```swift
enum ColorSelectorStyle {
    case grid
    case palette
}
```

## See Also

- ``Button``
- ``Surface``
- <doc:Theming>
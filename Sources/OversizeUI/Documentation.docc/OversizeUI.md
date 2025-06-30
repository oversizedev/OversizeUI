# ``OversizeUI``

A modern SwiftUI component library designed to accelerate app development while maintaining design consistency.

## Overview

OversizeUI is a comprehensive SwiftUI component library that provides production-ready UI components following modern design principles. Built with accessibility, theming, and developer experience in mind, OversizeUI enables developers to create beautiful, consistent applications across all Apple platforms.

### Key Features

- **🎨 Complete Design System**: Cohesive visual language with customizable themes
- **♿ Accessibility First**: WCAG 2.1 compliant with built-in accessibility features  
- **🌙 Dark Mode Support**: Native dark theme support with automatic color adaptation
- **📱 Multi-Platform**: iOS, macOS, tvOS, watchOS, and visionOS support
- **🎛️ Highly Customizable**: Flexible theming system with extensive customization options
- **📚 Well Documented**: Comprehensive documentation with live examples

### Quick Start

```swift
import SwiftUI
import OversizeUI

struct ContentView: View {
    @State private var name = ""
    @State private var selectedColor = Color.blue
    
    var body: some View {
        VStack(spacing: .medium) {
            TextField("Enter your name", text: $name)
                .textFieldStyle(.default)
            
            ColorSelector(selection: $selectedColor)
                .colorSelectorStyle(.grid)
            
            Button("Get Started") {
                print("Welcome, \(name)!")
            }
            .buttonStyle(.primary)
            .controlSize(.large)
        }
        .padding()
        .surface()
    }
}
```

## Topics

### Getting Started

- <doc:GettingStarted>
- <doc:Architecture>
- <doc:Theming>

### Interface Components

- <doc:Avatar>
- <doc:Button>
- <doc:ColorSelector>
- <doc:GridSelect>
- <doc:TextField>
- <doc:Row>
- <doc:SegmentedControl>
- <doc:Select>
- <doc:Surface>
- <doc:SectionView>
- <doc:NoticeView>

### Design System

- <doc:Typography>
- <doc:Colors>
- <doc:Spacing>
- <doc:Icons>

### Best Practices

- <doc:Accessibility>
- <doc:BestPractices>

## See Also

- [Figma Design System](https://www.figma.com/community/file/1144847542164788208)
- [GitHub Repository](https://github.com/oversizedev/OversizeUI)
- [Example App](https://github.com/oversizedev/OversizeUI/tree/main/Example)
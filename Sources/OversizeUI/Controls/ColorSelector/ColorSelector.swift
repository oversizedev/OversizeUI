//
// Copyright © 2021 Alexander Romanov
// ColorSelector.swift, created on 11.09.2021
//

import SwiftUI

// swiftlint:disable opening_brace
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct ColorSelector: View {
    @Environment(\.colorSelectorStyle) var style
    @Binding private var selection: Color
    private var colors: [Color]

    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    public init(selection: Binding<Color>, colors: [Color] = Palette.baseColors) {
        _selection = selection
        self.colors = colors
    }

    public var body: some View {
        colorSelector
            .animation(.default, value: selection)
    }

    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    var colorSelector: some View {
        style
            .makeBody(
                configuration: ColorSelectorConfiguration(
                    label: ColorSelectorConfiguration.Label(content:
                        Group {
                            ZStack {
                                ColorPickerWithoutBorder(selection: $selection)
                                    .padding(.horizontal, .xxxSmall)
                                    .padding(.all, .small)

                                if !colors.contains(selection) {
                                    Circle()
                                        .stroke(selection, lineWidth: 3)
                                        .frame(width: 40, height: 40)
                                }
                            }

                            ForEach(colors, id: \.self) { color in
                                ZStack {
                                    #if os(iOS) || os(macOS)
                                        Circle()
                                            .fill(color)
                                            .frame(width: 32, height: 32)
                                            .overlay(
                                                Circle()
                                                    .strokeBorder(Color.border, lineWidth: 1)
                                            )
                                            .onTapGesture {
                                                selection = color
                                            }
                                            .padding(6)
                                    #endif

                                    if color == selection {
                                        Circle()
                                            .stroke(color, lineWidth: 3)
                                            .frame(width: 40, height: 40)
                                    }
                                }
                            }
                        }
                    )
                )
            )
    }
}

@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct ColorPickerWithoutBorder: View {
    @Binding var selection: Color

    public init(selection: Binding<Color>) {
        _selection = selection
    }

    public var body: some View {
        selection
            .frame(width: 0, height: 0, alignment: .center)
            .cornerRadius(19.0)
            .background(
                ZStack {
                    AngularGradient(
                        gradient: Gradient(colors:
                            [.red, .yellow, .green, .blue, .purple, .red]),
                        center: .center,
                        startAngle: .zero,
                        endAngle: .degrees(360)
                    ).cornerRadius(16)
                        .frame(width: 32, height: 32)

                    Circle()
                        .strokeBorder(Color.border, lineWidth: 1)
                }
            )
            .overlay(
                ColorPicker("", selection: $selection, supportsOpacity: false)
                    .labelsHidden().opacity(0.015)
            )
            .animation(.default, value: selection)
    }
}

@available(watchOS, unavailable)
@available(tvOS, unavailable)
struct ColorSelector_Previews: PreviewProvider {
    struct PreviewViewHorizontal: View {
        @State var color = Color.red
        var body: some View {
            ColorSelector(selection: $color)
        }
    }

    struct PreviewViewGrid: View {
        @State var color = Color.red
        var body: some View {
            ColorSelector(selection: $color)
                .colorSelectorStyle(GridColorSelectorStyle())
        }
    }

    static var previews: some View {
        Group {
            PreviewViewHorizontal()
            PreviewViewGrid()
        }.previewLayout(.fixed(width: 375, height: 300))
    }
}

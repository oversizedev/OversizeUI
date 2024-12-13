//
// Copyright © 2021 Alexander Romanov
// TextField.swift, created on 07.06.2020
//

import SwiftUI

// swiftlint:disable identifier_name
@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
public struct LabeledTextFieldStyle: TextFieldStyle {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.fieldLabelPosition) private var fieldPlaceholderPosition: FieldLabelPosition
    @Environment(\.fieldPosition) private var fieldPosition: VerticalAlignment?
    @Environment(\.platform) private var platform: Platform
    @FocusState private var isFocused: Bool
    @Binding private var text: String
    private let placeholder: String

    public init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        _text = text
    }

    public func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: platform == .macOS ? .xxxSmall : .xSmall) {
            if fieldPlaceholderPosition == .adjacent {
                Text(placeholder)
                    .subheadline(.medium)
                    .foregroundColor(platform == .macOS ? .onSurfaceSecondary : .onSurfacePrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: platform == .macOS ? 4 : 0)
            }
            ZStack(alignment: .leading) {
                labelTextView
                configuration
                    .headline(.medium)
                    .foregroundColor(.onSurfacePrimary)
                    .padding(padding)
                    .offset(y: fieldOffset)
                    .focused($isFocused)
                #if os(macOS)
                    .if(fieldPlaceholderPosition == .adjacent) {
                        $0.textFieldStyle(.roundedBorder).controlSize(.large)
                    }
                    .if(fieldPlaceholderPosition != .adjacent) {
                        $0.textFieldStyle(.plain)
                    }
                #endif
            }
            .background(fieldBackground)
            .overlay(overlay)
        }
        .animation(.easeIn(duration: 0.10), value: text)
    }

    private var padding: EdgeInsets {
        switch fieldPlaceholderPosition {
        case .default:
            #if os(macOS)
            return .init(.xxSmall)
            #else
            return .init(.small)
            #endif
        case .overInput:
            #if os(macOS)
            return .init(.xSmall)
            #else
            return .init(
                top: Space.xxxSmall.rawValue + Space.small.rawValue,
                leading: Space.small.rawValue,
                bottom: Space.xxxSmall.rawValue + Space.small.rawValue,
                trailing: Space.small.rawValue
            )
            #endif
        case .adjacent:
            #if os(macOS)
            return .init(.zero)
            #else
            return .init(.small)
            #endif
        }
    }

    @ViewBuilder
    private var fieldBackground: some View {
        switch fieldPosition {
        case .top, .bottom, .center:
            #if canImport(UIKit)
            RoundedRectangleCorner(
                radius: fieldRadius,
                corners: backgroundShapeCorners
            )
            .fill(isFocused ? Color.surfacePrimary : Color.surfaceSecondary)
            #else
            if fieldPlaceholderPosition != .adjacent {
                RoundedRectangleCorner(
                    radius: fieldRadius,
                    corners: backgroundShapeCorners
                )
                .fill(isFocused ? Color.surfacePrimary : Color.surfaceSecondary)
            }
            #endif

        default:
            #if canImport(UIKit)
            RoundedRectangle(
                cornerRadius: fieldRadius,
                style: .continuous
            )
            .fill(isFocused ? Color.surfacePrimary : Color.surfaceSecondary)
            #else
            if fieldPlaceholderPosition != .adjacent {
                RoundedRectangle(
                    cornerRadius: fieldRadius,
                    style: .continuous
                )
                .fill(isFocused ? Color.surfacePrimary : Color.surfaceSecondary)
            }
            #endif
        }
    }

    private var fieldRadius: Radius {
        #if os(macOS)
        return .small
        #else
        return .medium
        #endif
    }

    #if canImport(UIKit)
    private var backgroundShapeCorners: UIRectCorner {
        switch fieldPosition {
        case .top:
            [.topLeft, .topRight]
        case .bottom:
            [.bottomLeft, .bottomRight]
        case .center:
            []
        default:
            [.allCorners]
        }
    }
    #endif

    #if canImport(AppKit)
    private var backgroundShapeCorners: RectCorner {
        switch fieldPosition {
        case .top:
            [.topLeft, .topRight]
        case .bottom:
            [.bottomLeft, .bottomRight]
        case .center:
            []
        default:
            [.allCorners]
        }
    }
    #endif

    private var fieldOffset: CGFloat {
        switch fieldPlaceholderPosition {
        case .default, .adjacent:
            .zero
        case .overInput:
            #if os(macOS)
            text.isEmpty && !isFocused ? -2 : text.isEmpty ? 0 : isFocused ? 9 : 7
            #else
            text.isEmpty ? 0 : 10
            #endif
        }
    }

    @ViewBuilder
    private var overlay: some View {
        switch fieldPosition {
        case .top, .bottom, .center:
            #if canImport(UIKit)
            RoundedRectangleCorner(radius: fieldRadius, corners: backgroundShapeCorners)
                .stroke(
                    overlayBorderColor,
                    lineWidth: isFocused ? 2 : CGFloat(theme.borderSize)
                )
            #elseif canImport(AppKit)
            if fieldPlaceholderPosition != .adjacent {
                RoundedRectangleCorner(radius: fieldRadius, corners: backgroundShapeCorners)
                    .stroke(
                        overlayBorderColor,
                        lineWidth: isFocused ? 2 : CGFloat(theme.borderSize)
                    )
            }
            #endif
        default:
            #if canImport(UIKit)
            RoundedRectangle(
                cornerRadius: fieldRadius,
                style: .continuous
            )
            .stroke(overlayBorderColor, lineWidth: isFocused ? 2 : CGFloat(theme.borderSize))
            #else
            if fieldPlaceholderPosition != .adjacent {
                RoundedRectangle(
                    cornerRadius: fieldRadius,
                    style: .continuous
                )
                .stroke(overlayBorderColor, lineWidth: isFocused ? 2 : CGFloat(theme.borderSize))
            }
            #endif
        }
    }

    @ViewBuilder
    private var labelTextView: some View {
        switch fieldPlaceholderPosition {
        case .default:
            if isFocused {
                Text(placeholder)
                    .subheadline()
                    .onSurfaceTertiaryForeground()
                    .opacity(0.7)
                #if os(macOS)
                    .padding(.xSmall)
                #else
                    .padding(.small)
                #endif
            }
        case .adjacent:
            EmptyView()
        case .overInput:
            Text(placeholder)
                .font(text.isEmpty ? .headline : .subheadline)
                .fontWeight(text.isEmpty ? .medium : .semibold)
                .onSurfaceTertiaryForeground()
            #if os(macOS)
                .padding(.xSmall)
                .offset(y: text.isEmpty ? 0 : -10)
            #else
                .padding(.small)
                .offset(y: text.isEmpty ? 0 : -13)
            #endif
                .opacity(text.isEmpty ? 0 : 1)
        }
    }

    private var overlayBorderColor: Color {
        if isFocused {
            Color.accentColor
        } else if theme.borderTextFields {
            Color.border
        } else {
            Color.clear
        }
    }
}

@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
public extension TextFieldStyle where Self == LabeledTextFieldStyle {
    static var `default`: LabeledTextFieldStyle {
        LabeledTextFieldStyle(placeholder: "", text: .constant(""))
    }

    static func placeholder(_ placeholder: String, text: Binding<String> = .constant("")) -> LabeledTextFieldStyle {
        LabeledTextFieldStyle(placeholder: placeholder, text: text)
    }
}

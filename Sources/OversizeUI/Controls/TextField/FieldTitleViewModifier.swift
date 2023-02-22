//
// Copyright © 2021 Alexander Romanov
// TextFieldExtended.swift, created on 20.02.2023
//

import SwiftUI

public struct TextFieldTitleModifier: ViewModifier {
    @Environment(\.theme) private var theme: ThemeSettings
    @Binding public var helperText: String
    @Binding public var helperStyle: TextFieldHelperStyle
    public init(helperText: Binding<String>, helperStyle: Binding<TextFieldHelperStyle>) {
        _helperText = helperText
        _helperStyle = helperStyle
    }

    public func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: .xSmall) {
            Text("Clinic")
                .subheadline(.semibold)
                .onSurfaceHighEmphasisForegroundColor()

           content
        }
    }
}

public extension View {
    func helper(_ text: Binding<String>, style: Binding<TextFieldHelperStyle>) -> some View {
        modifier(TextFieldHelperModifier(helperText: text, helperStyle: style))
    }
}





//VStack(alignment: .leading, spacing: .xSmall) {
//    Text("Clinic")
//        .subheadline(.semibold)
//        .foregroundColor(.onSurfaceHighEmphasis)
//        .paddingContent(.horizontal)

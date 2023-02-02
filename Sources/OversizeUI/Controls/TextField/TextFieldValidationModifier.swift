//
// Copyright © 2023 Alexander Romanov
// TextFieldValidationModifier.swift
//

import SwiftUI

public struct TextFieldValidationModifier: ViewModifier {
    @Environment(\.theme) private var theme: ThemeSettings
    @Binding public var validation: Validation
    public init(validation: Binding<Validation>) {
        _validation = validation
    }

    public func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content

            switch validation {
            case .success:
                EmptyView()
            case let .failure(message):
                Text(message)
                    .subheadline(.semibold)
                    .foregroundColor(.error)
            }
        }
    }
}

public extension View {
    func validationHelper(_ validation: Binding<Validation>) -> some View {
        modifier(TextFieldValidationModifier(validation: validation))
    }
}

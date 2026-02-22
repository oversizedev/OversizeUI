//
// Copyright © 2021 Alexander Romanov
// FieldHelperModifier.swift, created on 02.02.2023
//

import SwiftUI

public extension View {
    @available(*, deprecated, renamed: "fieldHelper")
    func helper(_ text: Binding<String>, style: Binding<FieldHelperStyle>) -> some View {
        modifier(FieldHelperViewModifier(helperText: text, helperStyle: style))
    }
}

//
// Copyright © 2021 Alexander Romanov
// Checkbox.swift, created on 07.02.2023
//

import SwiftUI

public enum CheckboxAlignment: Sendable {
    case leading, trailing
}

public struct Checkbox<Label: View>: View {
    @Environment(\.rowContentMargins) private var contentInset: EdgeSpaceInsets
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Binding var isOn: Bool
    private let label: () -> Label?
    private let alignment: CheckboxAlignment
    private var title: String?
    private let action: (() -> Void)?

    public init(
        isOn: Binding<Bool>,
        alignment: CheckboxAlignment = .trailing,
        action: (() -> Void)? = nil,
        @ViewBuilder label: @escaping () -> Label? = { nil }
    ) {
        _isOn = isOn
        self.alignment = alignment
        self.action = action
        self.label = label
    }

    public var body: some View {
        Button {
            isOn.toggle()
            if action != nil {
                action?()
            }
        } label: {
            HStack(spacing: .xSmall) {
                content(alignment: alignment)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.row)
    }

    @ViewBuilder
    private func content(alignment: CheckboxAlignment) -> some View {
        switch alignment {
        case .leading:
            checkboxImage(isEnabled: isEnabled, isOn: isOn)
                .padding(.leading, contentInset.leading)
            labelContent
            Spacer()

        case .trailing:
            labelContent
            Spacer()
            checkboxImage(isEnabled: isEnabled, isOn: isOn)
                .padding(.trailing, contentInset.trailing)
        }
    }

    @ViewBuilder
    private var labelContent: some View {
        if let label = label() {
            label
        } else {
            Text(title ?? "")
                .headline(.medium)
                .foregroundColor(foregroundColor)
                .padding(contentInset)
        }
    }

    @ViewBuilder
    private func checkboxImage(isEnabled: Bool, isOn: Bool) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: Radius.small, style: .continuous)
                .strokeBorder(Color.onSurfaceTertiary.opacity(isEnabled ? 1 : 0.5), lineWidth: 2.5)
                .frame(width: 24, height: 24)
                .opacity(isOn ? 0 : 1)

            RoundedRectangle(cornerRadius: Radius.small, style: .continuous).fill(Color.accent.opacity(isEnabled ? 1 : 0.5))
                .frame(width: 24, height: 24)
                .opacity(isOn ? 1 : 0)

            Image(systemName: "checkmark")
                .font(.caption.weight(.black))
                .foregroundColor(.onPrimary.opacity(isEnabled ? 1 : 0.5))
                .opacity(isOn ? 1 : 0)
        }
    }

    private var foregroundColor: Color {
        if isEnabled {
            Color.onSurfacePrimary
        } else {
            Color.onSurfaceTertiary
        }
    }
}

public extension Checkbox where Label == EmptyView {
    init(
        _ title: String,
        isOn: Binding<Bool>,
        alignment: CheckboxAlignment = .trailing,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        _isOn = isOn
        self.alignment = alignment
        label = { nil }
        self.action = action
    }
}

/*
 struct Checkbox_LibraryContent: LibraryContentProvider {
     var views: [LibraryItem] {
         LibraryItem(
             Checkbox(isOn: .constant(false), label: {
                 Text("Text")
             }),
             title: "Checkbox", category: .control
         )
     }
 }
 */

struct Checkbox_preview: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 24) {
            Checkbox(isOn: .constant(true), label: {
                Text("Text")
            })

            Checkbox(isOn: .constant(false), alignment: .leading, label: {
                Text("Text")
            })

            Checkbox(isOn: .constant(true), alignment: .trailing, label: {
                Text("Text")
            })

            Checkbox("Text", isOn: .constant(false), alignment: .leading)

            Checkbox("Text", isOn: .constant(true), alignment: .trailing)

            Checkbox("Text", isOn: .constant(false))
                .disabled(true)

            Checkbox("Text", isOn: .constant(true))
                .disabled(true)
        }
        .padding()
    }
}

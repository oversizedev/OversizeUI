//
// Copyright © 2023 Alexander Romanov
// Checkbox.swift
//

import SwiftUI

public enum CheckboxAlignment {
    case leading, trailing
}

public struct Checkbox<Label: View>: View {
    @Environment(\.rowContentInset) private var contentInset: EdgeSpaceInsets
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Binding var isOn: Bool
    private let label: () -> Label?
    private let alignment: CheckboxAlignment
    private var title: String?

    public init(isOn: Binding<Bool>, alignment: CheckboxAlignment = .trailing, @ViewBuilder label: @escaping () -> Label? = { nil }) {
        _isOn = isOn
        self.alignment = alignment
        self.label = label
    }

    public var body: some View {
        Button {
            isOn.toggle()
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
        if let label = self.label() {
            label
        } else {
            Text(title ?? "")
                .headline(.semibold)
                .foregroundColor(foregroundColor)
                .padding(contentInset)
        }
    }

    @ViewBuilder
    private func checkboxImage(isEnabled: Bool, isOn: Bool) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: Radius.small, style: .continuous)
                .strokeBorder(Color.onSurfaceDisabled.opacity(isEnabled ? 1 : 0.5), lineWidth: 2.5)
                .frame(width: 24, height: 24)
                .opacity(isOn ? 0 : 1)

            RoundedRectangle(cornerRadius: Radius.small, style: .continuous).fill(Color.accent.opacity(isEnabled ? 1 : 0.5))
                .frame(width: 24, height: 24)
                .opacity(isOn ? 1 : 0)

            Image(systemName: "checkmark")
                .font(.caption.weight(.black))
                .foregroundColor(.onPrimaryHighEmphasis.opacity(isEnabled ? 1 : 0.5))
                .opacity(isOn ? 1 : 0)
        }
    }

    private var foregroundColor: Color {
        if isEnabled {
            return Color.onSurfaceHighEmphasis
        } else {
            return Color.onSurfaceDisabled
        }
    }
}

public extension Checkbox where Label == EmptyView {
    init(_ title: String, isOn: Binding<Bool>, alignment: CheckboxAlignment = .trailing) {
        self.title = title
        _isOn = isOn
        self.alignment = alignment
        label = { nil }
    }
}

@available(iOS 14.0, *)
struct Checkbox_LibraryContent: LibraryContentProvider {
    var views: [LibraryItem] {
        LibraryItem(
            Checkbox(isOn: .constant(false)) {
                Text("Text")
            },
            title: "Checkbox", category: .control
        )
    }
}

struct Checkbox_preview: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 24) {
            Checkbox(isOn: .constant(true)) {
                Text("Text")
            }

            Checkbox(isOn: .constant(false), alignment: .leading, label: {
                Text("Text")
            })

            Checkbox(isOn: .constant(true), alignment: .trailing) {
                Text("Text")
            }

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

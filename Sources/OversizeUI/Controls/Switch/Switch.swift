//
// Copyright © 2021 Alexander Romanov
// Switch.swift, created on 07.02.2023
//

import SwiftUI

public enum SwitchAlignment {
    case leading, trailing
}

public struct Switch<Label: View>: View {
    @Environment(\.rowContentInset) private var contentInset: EdgeSpaceInsets
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Binding var isOn: Bool
    private let label: () -> Label?
    private let alignment: SwitchAlignment
    private var title: String?

    public init(isOn: Binding<Bool>, alignment: SwitchAlignment = .trailing, @ViewBuilder label: @escaping () -> Label? = { nil }) {
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
    private func content(alignment: SwitchAlignment) -> some View {
        switch alignment {
        case .leading:
            switchImage(isEnabled: isEnabled)
                .padding(.leading, contentInset.leading)
            labelContent
            Spacer()

        case .trailing:
            labelContent
            Spacer()
            switchImage(isEnabled: isEnabled)
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
    private func switchImage(isEnabled: Bool) -> some View {
        Toggle("", isOn: $isOn)
            .labelsHidden()
            .disabled(!isEnabled)
    }

    private var foregroundColor: Color {
        if isEnabled {
            return Color.onSurfaceHighEmphasis
        } else {
            return Color.onSurfaceDisabled
        }
    }
}

public extension Switch where Label == EmptyView {
    init(_ title: String, isOn: Binding<Bool>, alignment: SwitchAlignment = .trailing) {
        self.title = title
        _isOn = isOn
        self.alignment = alignment
        label = { nil }
    }
}

@available(iOS 14.0, *)
struct Switch_LibraryContent: LibraryContentProvider {
    var views: [LibraryItem] {
        LibraryItem(
            Switch(isOn: .constant(false)) {
                Text("Text")
            },
            title: "Checkbox", category: .control
        )
    }
}

struct Switch_preview: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 24) {
            Switch(isOn: .constant(true)) {
                Text("Text")
            }

            Switch(isOn: .constant(false), alignment: .leading, label: {
                Text("Text")
            })

            Switch(isOn: .constant(true), alignment: .trailing) {
                Text("Text")
            }

            Switch("Text", isOn: .constant(false), alignment: .leading)

            Switch("Text", isOn: .constant(true), alignment: .trailing)

            Switch("Text", isOn: .constant(false))
                .disabled(true)

            Switch("Text", isOn: .constant(true))
                .disabled(true)
        }
        .padding()
    }
}

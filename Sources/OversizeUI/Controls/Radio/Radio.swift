//
// Copyright © 2021 Alexander Romanov
// Radio.swift, created on 07.02.2023
//

import SwiftUI

public enum RadioAlignment {
    case leading, trailing
}

public struct Radio<Label: View>: View {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.rowContentMargins) private var contentInset: EdgeSpaceInsets
    private var isOn: Bool
    private let label: () -> Label?
    private let alignment: RadioAlignment
    private var verticalAlignment: VerticalAlignment = .center
    private var title: String?
    private let action: (() -> Void)?

    public init(
        isOn: Bool,
        alignment: RadioAlignment = .trailing,
        verticalAlignment: VerticalAlignment = .center,
        action: (() -> Void)? = nil,
        @ViewBuilder label: @escaping () -> Label? = { nil }
    ) {
        self.isOn = isOn
        self.alignment = alignment
        self.verticalAlignment = verticalAlignment
        self.action = action
        self.label = label
    }

    public var body: some View {
        if action != nil {
            Button {
                action?()
            } label: {
                HStack(alignment: verticalAlignment, spacing: .xSmall) {
                    content(alignment: alignment)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.row)
        } else {
            HStack(alignment: verticalAlignment, spacing: .xSmall) {
                content(alignment: alignment)
            }
            .contentShape(Rectangle())
        }
    }

    @ViewBuilder
    private func content(alignment: RadioAlignment) -> some View {
        switch alignment {
        case .leading:
            radioImage(isEnabled: isEnabled, isOn: isOn)
                .padding(.leading, contentInset.leading)
            labelContent

        case .trailing:
            labelContent
            Spacer()
            radioImage(isEnabled: isEnabled, isOn: isOn)
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

    private func radioImage(isEnabled: Bool, isOn: Bool) -> some View {
        ZStack {
            Circle()
                .stroke(Color.onSurfaceTertiary.opacity(isEnabled ? 1 : 0.5), lineWidth: 4)
                .frame(width: 24, height: 24)
                .cornerRadius(12)
                .opacity(isOn ? 0 : 1)

            Circle().fill(Color.accent.opacity(isEnabled ? 1 : 0.5))
                .frame(width: 24, height: 24)
                .cornerRadius(12)
                .opacity(isOn ? 1 : 0)

            Circle().fill(Color.white.opacity(isEnabled ? 1 : 0.8)).frame(width: 8, height: 8)
                .cornerRadius(4)
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

public extension Radio where Label == EmptyView {
    init(
        _ title: String,
        isOn: Bool,
        alignment: RadioAlignment = .trailing,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.isOn = isOn
        self.alignment = alignment
        label = { nil }
        self.action = action
    }
}

/*
 struct Radio_LibraryContent: LibraryContentProvider {
     var views: [LibraryItem] {
         LibraryItem(
             Radio(isOn: false, alignment: .leading, label: {
                 Text("Text")
             }),
             title: "Chip", category: .control
         )
     }
 }
 */

struct Radio_preview: PreviewProvider {
    struct RadioPreview: View {
        var data = ["One", "Two", "Three", "Four"]
        @State var selection = ""
        var body: some View {
            RadioPicker(data, selection: $selection) { item in
                Text(item)
            }
            .onChange(of: selection) { selectedItem in
                print(selectedItem)
            }
        }
    }

    static var previews: some View {
        VStack {
            RadioPreview()

            Radio(isOn: false, alignment: .leading, label: {
                Text("Text")
            })
            Radio(isOn: true, alignment: .trailing, label: {
                Text("Text")
            })
            Radio("Text", isOn: false, alignment: .leading)

            Radio("Text", isOn: true, alignment: .trailing)

            Radio("Text", isOn: true, alignment: .leading)
                .disabled(true)

            Radio("Text", isOn: false, alignment: .leading)
                .disabled(true)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

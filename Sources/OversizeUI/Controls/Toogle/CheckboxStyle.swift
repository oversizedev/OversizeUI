//
// Copyright © 2022 Alexander Romanov
// CheckboxStyle.swift
//

import SwiftUI

public struct CheckboxStyle: ToggleStyle {
    @Environment(\.controlPadding) var controlPadding: ControlPadding

    public func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
                .headline(.semibold)
                .foregroundColor(.onSurfaceHighEmphasis)

            Spacer()

            ZStack {
                RoundedRectangle(cornerRadius: Radius.small, style: .continuous)
                    .strokeBorder(Color.onSurfaceDisabled, lineWidth: 2.5)
                    .frame(width: 24, height: 24)
                    .opacity(configuration.isOn ? 0 : 1)

                RoundedRectangle(cornerRadius: Radius.small, style: .continuous).fill(Color.accent)
                    .frame(width: 24, height: 24)
                    .opacity(configuration.isOn ? 1 : 0)

                Image(systemName: "checkmark")
                    .font(.caption.weight(.black))
                    .foregroundColor(.onPrimaryHighEmphasis)
                    .opacity(configuration.isOn ? 1 : 0)
            }
        }
        .padding(.vertical, verticalPadding)
        .padding(.horizontal, controlPadding.horizontal)
    }

    private var verticalPadding: CGFloat {
        switch controlPadding.vertical {
        case .zero:
            return .zero
        case .xxSmall:
            return .zero
        default:
            return controlPadding.vertical.rawValue - Space.xxSmall.rawValue
        }
    }
}

public extension ToggleStyle where Self == CheckboxStyle {
    static var checkboxRow: CheckboxStyle { .init() }
}

struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        SectionView {
            VStack {
                Toggle(isOn: .constant(true)) {
                    Label("Label", systemImage: "folder.fill")
                        .labelStyle(.row("Subtitle"))
                }
                .toggleStyle(.checkboxRow)

                Toggle(isOn: .constant(true)) {
                    Label("Label", systemImage: "folder.fill")
                        .labelStyle(.row)
                }
                .toggleStyle(.checkboxRow)

                Divider()

                Toggle("Title", isOn: .constant(true))
                    .toggleStyle(.checkboxRow)

                Toggle("Title", isOn: .constant(false))
                    .toggleStyle(.checkboxRow)
            }
        }
        .background(Color.surfaceSecondary)
    }
}

//
// Copyright © 2021 Alexander Romanov
// CheckboxStyle.swift, created on 23.12.2022
//

import SwiftUI

public struct CheckboxStyle: ToggleStyle {
    @Environment(\.controlMargin) var controlPadding: ControlMargin

    public func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
                .headline(.semibold)
                .foregroundColor(.onSurfacePrimary)

            Spacer()

            ZStack {
                RoundedRectangle(cornerRadius: Radius.small, style: .continuous)
                    .strokeBorder(Color.onSurfaceTertiary, lineWidth: 2.5)
                    .frame(width: 24, height: 24)
                    .opacity(configuration.isOn ? 0 : 1)

                RoundedRectangle(cornerRadius: Radius.small, style: .continuous).fill(Color.accent)
                    .frame(width: 24, height: 24)
                    .opacity(configuration.isOn ? 1 : 0)

                Image(systemName: "checkmark")
                    .font(.caption.weight(.black))
                    .foregroundColor(.onPrimary)
                    .opacity(configuration.isOn ? 1 : 0)
            }
        }
        .padding(.top, controlPadding.top.rawValue - Space.xxSmall.rawValue)
        .padding(.bottom, controlPadding.bottom.rawValue - Space.xxSmall.rawValue)
        .padding(.leading, controlPadding.leading)
        .padding(.trailing, controlPadding.trailing)
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

                Separator()

                Toggle("Title", isOn: .constant(true))
                    .toggleStyle(.checkboxRow)

                Toggle("Title", isOn: .constant(false))
                    .toggleStyle(.checkboxRow)

                Toggle("Title", isOn: .constant(false))
                    .toggleStyle(.checkboxRow)
            }
        }
        .background(Color.surfaceSecondary)
    }
}

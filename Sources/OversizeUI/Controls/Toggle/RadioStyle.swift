//
// Copyright © 2021 Alexander Romanov
// RadioStyle.swift, created on 23.12.2022
//

import SwiftUI

public struct RadioStyle: ToggleStyle {
    @Environment(\.controlMargin) var controlPadding: ControlMargin

    public func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
                .headline(.semibold)
                .foregroundColor(.onSurfacePrimary)

            Spacer()

            ZStack {
                Circle()
                    .stroke(Color.onSurfaceTertiary, lineWidth: 4)
                    .frame(width: 24, height: 24)
                    .cornerRadius(12)
                    .opacity(configuration.isOn ? 0 : 1)

                Circle().fill(Color.accent)
                    .frame(width: 24, height: 24)
                    .cornerRadius(12)
                    .opacity(configuration.isOn ? 1 : 0)

                Circle().fill(Color.white).frame(width: 8, height: 8)
                    .cornerRadius(4)
                    .opacity(configuration.isOn ? 1 : 0)
            }
        }
        .padding(.top, controlPadding.leading.rawValue - Space.xxSmall.rawValue)
        .padding(.bottom, controlPadding.bottom.rawValue - Space.xxSmall.rawValue)
        .padding(.leading, controlPadding.leading)
        .padding(.trailing, controlPadding.trailing)
    }
}

public extension ToggleStyle where Self == RadioStyle {
    static var radio: RadioStyle { .init() }
}

struct Radio_Previews: PreviewProvider {
    static var previews: some View {
        SectionView {
            VStack {
                Toggle(isOn: .constant(true)) {
                    Label("Label", systemImage: "folder.fill")
                        .labelStyle(.row("Subtitle"))
                }
                .toggleStyle(.radio)

                Toggle(isOn: .constant(true)) {
                    Label("Label", systemImage: "folder.fill")
                        .labelStyle(.row)
                }
                .toggleStyle(.radio)

                Separator()

                Toggle("Title", isOn: .constant(true))
                    .toggleStyle(.radio)

                Toggle("Title", isOn: .constant(false))
                    .toggleStyle(.radio)
            }
        }
        .background(Color.surfaceSecondary)
    }
}

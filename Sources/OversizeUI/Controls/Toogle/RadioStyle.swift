//
// Copyright © 2022 Alexander Romanov
// RadioStyle.swift
//

import SwiftUI

public struct RadioStyle: ToggleStyle {
    @Environment(\.controlPadding) var controlPadding: ControlPadding

    public func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
                .headline(.semibold)
                .foregroundColor(.onSurfaceHighEmphasis)

            Spacer()

            ZStack {
                Circle()
                    .stroke(Color.onSurfaceDisabled, lineWidth: 4)
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

                Divider()

                Toggle("Title", isOn: .constant(true))
                    .toggleStyle(.radio)

                Toggle("Title", isOn: .constant(false))
                    .toggleStyle(.radio)
            }
        }
        .background(Color.surfaceSecondary)
    }
}

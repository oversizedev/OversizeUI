//
// Copyright © 2021 Alexander Romanov
// Created on 22.09.2021
//

import SwiftUI

public enum RowTrailingType {
    case none
    case radio(isOn: Binding<Bool>)
    case checkbox(isOn: Binding<Bool>)
    case toggle(isOn: Binding<Bool>)
    case toggleWithArrowButton(isOn: Binding<Bool>, action: (() -> Void)? = nil)
    case arrowIcon
}

public enum RowLeadingType {
    case none
    case icon(_ name: Icons)
    case iconOnSurface(_ name: Icons)
    case image(_ image: Image)
    case avatar(_ avatar: AvatarView)
}

private struct RowActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.surfaceSecondary : Color.clear)
            .contentShape(Rectangle())
    }
}

public struct Row: View {
    private enum Constants {
        /// Spacing
        static var spacingIconAndText: CGFloat { Space.xxSmall.rawValue }
    }

    private let title: String
    private let subtitle: String

    private let paddingVertical: Space
    private let paddingHorizontal: Space

    private let leadingType: RowLeadingType
    private let trallingType: RowTrailingType

    private let action: (() -> Void)?

    public init(_ title: String,
                subtitle: String = "",
                leadingType: RowLeadingType = .none,
                trallingType: RowTrailingType = .none,
                paddingHorizontal: Space = .medium,
                paddingVertical: Space = .small,
                action: (() -> Void)? = nil)
    {
        self.title = title
        self.subtitle = subtitle
        self.leadingType = leadingType
        self.trallingType = trallingType
        self.paddingVertical = paddingVertical
        self.paddingHorizontal = paddingHorizontal
        self.action = action
    }

    public var body: some View {
        getSurface()
    }

    @ViewBuilder
    private func getSurface() -> some View {
        if action != nil {
            Button {
                (action)?()
            } label: {
                content
            }
            .buttonStyle(RowActionButtonStyle())
        } else {
            content
        }
    }

    public var content: some View {
        VStack(alignment: .leading) {
            HStack(spacing: .xSmall) {
                leading()

                text

                Spacer()

                tralling()
            }
        }
        .padding(.vertical, paddingVertical.rawValue)
        .padding(.horizontal, paddingHorizontal.rawValue)
    }

    @ViewBuilder
    private func leading() -> some View {
        switch leadingType {
        case .none:
            EmptyView()
        case let .icon(icon):
            Icon(icon)
                .padding(.trailing, Constants.spacingIconAndText)

        case let .image(image):
            image
                .resizable()
                .frame(width: 32, height: 32)

        case let .avatar(avatar):
            avatar
        case let .iconOnSurface(icon):
            Surface(background: .secondary, padding: .xxSmall) {
                Icon(icon)
            }.padding(.trailing, Constants.spacingIconAndText)
        }
    }

    @ViewBuilder
    private func tralling() -> some View {
        switch trallingType {
        case .none:

            EmptyView()

        case let .toggle(isOn):
            Toggle(isOn: isOn) {}
                .labelsHidden()

        case let .radio(isOn: isOn):

            if isOn.wrappedValue {
                ZStack {
                    Circle().fill(Color.accent).frame(width: 24, height: 24)
                        .cornerRadius(12)

                    Circle().fill(Color.white).frame(width: 8, height: 8)
                        .cornerRadius(4)
                }

            } else {
                Circle()
                    .stroke(Color.onSurfaceDisabled, lineWidth: 4)
                    .frame(width: 24, height: 24)
                    .cornerRadius(12)
            }
        case let .checkbox(isOn: isOn):

            if isOn.wrappedValue {
                ZStack {
                    Circle().fill(Color.accent).frame(width: 24, height: 24)
                        .cornerRadius(12)

                    Circle().fill(Color.white).frame(width: 8, height: 8)
                        .cornerRadius(4)
                }

            } else {
                Circle()
                    .stroke(Color.onSurfaceDisabled, lineWidth: 4)
                    .frame(width: 24, height: 24)
                    .cornerRadius(12)
            }
        case let .toggleWithArrowButton(isOn: isOn, action: action):

            HStack {
                Toggle(isOn: isOn) {}
                    .labelsHidden()

                Button(action: action ?? {}, label: {
                    Icon(.chevronRight, color: .onSurfaceDisabled)
                })
            }
        case .arrowIcon:
            Icon(.chevronRight, color: .onSurfaceDisabled)
        }
    }

    var text: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontStyle(.subtitle1, color: .onSurfaceHighEmphasis)

            if subtitle != "" {
                Text(title)
                    .fontStyle(.subtitle2)
                    .foregroundColor(.onSurfaceMediumEmphasis)
            }
        }
    }

    func createToggle() {}
}

// swiftlint:disable all
struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Row("Title")

            Row("Title", subtitle: "Subtitle")

            Row("Title", subtitle: "Subtitle", leadingType: .icon(.calendar), trallingType: .radio(isOn: .constant(true)), paddingVertical: .medium)

            Row("Title", subtitle: "Subtitle", leadingType: .icon(.calendar), trallingType: .toggle(isOn: .constant(true)), paddingVertical: .medium)

            Row("Title", subtitle: "Subtitle", leadingType: .icon(.calendar), trallingType: .radio(isOn: .constant(false)), paddingVertical: .small)

            Row("Title", subtitle: "Subtitle", leadingType: .avatar(AvatarView(firstName: "Name")), trallingType: .radio(isOn: .constant(false)), paddingVertical: .small)

            Row("Title", trallingType: .toggleWithArrowButton(isOn: .constant(true), action: nil))
        }
        // .padding()
        .previewLayout(.fixed(width: 375, height: 60))
    }
}

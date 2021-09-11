//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public enum TrailingType {
    case none
    case radio
    case toggle
}

public enum LeadingType {
    case none
    case icon(_ name: Icons)
    case iconOnSurface(_ name: Icons)
    case image(_ image: Image)
    case avatar(_ avatar: AvatarView)
}

public struct Row: View {
    private enum Constants {
        /// Spacing
        static var spacingIconAndText: CGFloat { Space.xxSmall.rawValue }
    }

    private var title: String
    private var subtitle: String

    private var paddingVertical: Space
    private var paddingHorizontal: Space
    @Binding private var toggle: Bool

    private var leadingType: LeadingType
    private var trallingType: TrailingType

    public init(_ title: String,
                subtitle: String = "",
                leadingType: LeadingType = .none,
                trallingType: TrailingType = .none,
                paddingHorizontal: Space = .medium,
                paddingVertical: Space = .small,
                toggle: Binding<Bool> = .constant(false))
    {
        self.title = title
        self.subtitle = subtitle
        self.leadingType = leadingType
        self.trallingType = trallingType
        self.paddingVertical = paddingVertical
        self.paddingHorizontal = paddingHorizontal
        _toggle = toggle
    }

    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                leading()

                if trallingType == .toggle {
                    Toggle(isOn: $toggle) {
                        Text(title)
                            .fontStyle(.subtitle1)
                            .foregroundColor(.onSurfaceHighEmphasis)
                    }

                } else if trallingType == .radio {
                    Text(title)
                        .fontStyle(.subtitle1)
                        .foregroundColor(.onSurfaceHighEmphasis)

                    Spacer()

                    if toggle {
                        ZStack {
                            Circle().fill(Color.primary).frame(width: 24, height: 24)
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

                } else {
                    VStack(alignment: .leading) {
                        Text(title)
                            .fontStyle(.subtitle1, color: .onSurfaceHighEmphasis)

                        if subtitle != "" {
                            Text(title)
                                .fontStyle(.subtitle2)
                                .foregroundColor(.onSurfaceMediumEmphasis)
                        }
                    }

                    Spacer()
                }
            }
        }.padding(.vertical, paddingVertical.rawValue)
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

    func createToggle() {}
}

// swiftlint:disable all
struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Row("Title")

            Row("Title", subtitle: "Subtitle")

            Row("Title", subtitle: "Subtitle", leadingType: .icon(.calendar), trallingType: .radio, paddingVertical: .medium)

            Row("Title", subtitle: "Subtitle", leadingType: .icon(.calendar), trallingType: .radio, paddingVertical: .small)
                .previewLayout(.sizeThatFits)
        }
        .padding()
        .previewLayout(.fixed(width: 375, height: 60))
    }
}

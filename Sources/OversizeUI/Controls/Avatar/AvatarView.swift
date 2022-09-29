//
// Copyright © 2022 Alexander Romanov
// AvatarView.swift
//

import SwiftUI

public enum AvatarSize: Int, CaseIterable {
    case small
    case medium
    case large
}

public struct AvatarView: View {
    private enum Constants {
        /// Size
        static var sizeS: CGFloat { Space.medium.rawValue }
        static var sizeM: CGFloat { Space.xLarge.rawValue }
        static var sizeL: CGFloat { Space.xxxLarge.rawValue }
        static var avatarTextSpaceS: CGFloat { .zero }
        static var avatarTextSpaceM: CGFloat { 2 }
        static var avatarTextSpaceL: CGFloat { 2 }
        static var backgroundColor: Gradient { Gradient(colors: [.red, .yellow, .green, .blue, .purple]) }
        static var borderColor: Color { Color.onPrimaryHighEmphasis }
        static var borderLineWidth: CGFloat { 2 }
    }

    let firstName: String
    let lastName: String
    let size: AvatarSize
    let avatar: Image?
    let stroke: Bool

    public init(firstName: String = "",
                lastName: String = "",
                size: AvatarSize = .medium,
                avatar: Image? = nil,
                stroke: Bool = false)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.size = size
        self.avatar = avatar
        self.stroke = stroke
    }

    public var body: some View {
        if let avatar {
            avatar
                .resizable()
                .frame(width: size == .small ? Constants.sizeS : size == .medium ? Constants.sizeM : Constants.sizeL,
                       height: size == .small ? Constants.sizeS : size == .medium ? Constants.sizeM : Constants.sizeL)
                .clipShape(Circle())
                .overlay(stroke ? Circle().stroke(Constants.borderColor, lineWidth: Constants.borderLineWidth) : nil)

        } else {
            ZStack {
                Circle()
                    .fill(LinearGradient(gradient:
                        Gradient(colors: [Color.warning, Color.success]), startPoint: .topLeading, endPoint: .bottom))
                    .frame(width: size == .small
                        ? Constants.sizeS
                        : size == .medium
                        ? Constants.sizeM
                        : Constants.sizeL,
                        height: size == .small
                            ? Constants.sizeS
                            : size == .medium
                            ? Constants.sizeM
                            : Constants.sizeL)
                    .overlay(stroke
                        ? Circle().stroke(Constants.borderColor, lineWidth: Constants.borderLineWidth)
                        : nil)

                HStack(spacing: size == .small
                    ? Constants.avatarTextSpaceS
                    : size == .medium ? Constants.avatarTextSpaceM
                    : Constants.avatarTextSpaceL) {
                        if firstName != "" {
                            Text(String(firstName.dropLast(firstName.count - 1)))
                                .fontStyle(size == .small ? .caption : size == .medium
                                    ? .title3
                                    : .largeTitle,
                                    color: .onPrimaryHighEmphasis)
                        }

                        if lastName != "" {
                            Text(String(lastName.dropLast(lastName.count - 1)))
                                .fontStyle(size == .small
                                    ? .caption
                                    : size == .medium
                                    ? .title3
                                    : .largeTitle,
                                    color: .onPrimaryHighEmphasis)
                        }
                    }
            }
        }
    }
}

// swiftlint:disable all
struct M7AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AvatarView(firstName: "Jhon", size: .small)
                .previewDisplayName("Only firsy name")

            AvatarView(firstName: "Jhon", lastName: "Smith", size: .small, stroke: true)
                .previewDisplayName("First name, last name and storke")

            AvatarView(size: .small, avatar: Image("empty", bundle: .module))
                .previewDisplayName("Only avatar")

            AvatarView(firstName: "Jhon", lastName: "Smith", size: .small, avatar: Image("empty", bundle: .module), stroke: true)
                .previewDisplayName("All data")

        }.previewLayout(.fixed(width: 24, height: 24))
            .background(Color.surfaceTertiary)

        Group {
            AvatarView(firstName: "Jhon", size: .medium)
                .previewDisplayName("Only firsy name")

            AvatarView(firstName: "Jhon", lastName: "Smith", size: .medium, stroke: true)
                .previewDisplayName("First name, last name and storke")

            AvatarView(size: .medium, avatar: Image("empty", bundle: .module))
                .previewDisplayName("Only avatar")

            AvatarView(firstName: "Jhon", lastName: "Smith", size: .medium, avatar: Image("empty", bundle: .module), stroke: true)
                .previewDisplayName("All data")

        }.previewLayout(.fixed(width: 48, height: 48))
            .background(Color.surfaceTertiary)

        Group {
            AvatarView(firstName: "Jhon", size: .large)
                .previewDisplayName("Only firsy name")

            AvatarView(firstName: "Jhon", lastName: "Smith", size: .large, stroke: true)
                .previewDisplayName("First name, last name and storke")

            AvatarView(size: .large, avatar: Image("empty", bundle: .module))
                .previewDisplayName("Only avatar")

            AvatarView(firstName: "Jhon", lastName: "Smith", size: .large, avatar: Image("empty", bundle: .module), stroke: true)
                .previewDisplayName("All data")

        }.previewLayout(.fixed(width: 96, height: 96))
            .background(Color.surfaceTertiary)
    }
}

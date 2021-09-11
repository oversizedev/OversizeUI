//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public enum AvatarSize: Int, CaseIterable {
    case small
    case m
    case l
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
    let avatar: Image
    let stroke: Bool

    public init(firstName: String = "",
                lastName: String = "",
                size: AvatarSize = .m,
                avatar: Image = Image(""),
                stroke: Bool = false)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.size = size
        self.avatar = avatar
        self.stroke = stroke
    }

    public var body: some View {
        if avatar != Image("") {
            avatar
                .resizable()
                .frame(width: size == .small ? Constants.sizeS : size == .m ? Constants.sizeM : Constants.sizeL,
                       height: size == .small ? Constants.sizeS : size == .m ? Constants.sizeM : Constants.sizeL)
                .clipShape(Circle())
                .overlay(stroke ? Circle().stroke(Constants.borderColor, lineWidth: Constants.borderLineWidth) : nil)

        } else {
            ZStack {
                Circle()
                    .fill(LinearGradient(gradient:
                        Gradient(colors: [Color.warning, Color.success]), startPoint: .topLeading, endPoint: .bottom))
                    .frame(width: size == .small ? Constants.sizeS : size == .m ? Constants.sizeM : Constants.sizeL,
                           height: size == .small ? Constants.sizeS : size == .m ? Constants.sizeM : Constants.sizeL)
                    .overlay(stroke
                        ? Circle().stroke(Constants.borderColor, lineWidth: Constants.borderLineWidth)
                        : nil)

                HStack(spacing: size == .small
                    ? Constants.avatarTextSpaceS
                    : size == .m ? Constants.avatarTextSpaceM
                    : Constants.avatarTextSpaceL) {
                        if firstName != "" {
                            Text(String(firstName.dropLast(firstName.count - 1)))
                                .fontStyle(size == .small ? .caption : size == .m
                                    ? .title3
                                    : .largeTitle,
                                    color: .onPrimaryHighEmphasis)
                        }

                        if lastName != "" {
                            Text(String(lastName.dropLast(lastName.count - 1)))
                                .fontStyle(size == .small
                                    ? .caption
                                    : size == .m
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
            AvatarView(firstName: "Jhon", size: .m)
                .previewDisplayName("Only firsy name")

            AvatarView(firstName: "Jhon", lastName: "Smith", size: .m, stroke: true)
                .previewDisplayName("First name, last name and storke")

            AvatarView(size: .m, avatar: Image("empty", bundle: .module))
                .previewDisplayName("Only avatar")

            AvatarView(firstName: "Jhon", lastName: "Smith", size: .m, avatar: Image("empty", bundle: .module), stroke: true)
                .previewDisplayName("All data")

        }.previewLayout(.fixed(width: 48, height: 48))
            .background(Color.surfaceTertiary)

        Group {
            AvatarView(firstName: "Jhon", size: .l)
                .previewDisplayName("Only firsy name")

            AvatarView(firstName: "Jhon", lastName: "Smith", size: .l, stroke: true)
                .previewDisplayName("First name, last name and storke")

            AvatarView(size: .l, avatar: Image("empty", bundle: .module))
                .previewDisplayName("Only avatar")

            AvatarView(firstName: "Jhon", lastName: "Smith", size: .l, avatar: Image("empty", bundle: .module), stroke: true)
                .previewDisplayName("All data")

        }.previewLayout(.fixed(width: 96, height: 96))
            .background(Color.surfaceTertiary)
    }
}

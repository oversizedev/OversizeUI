//
// Copyright © 2021 Alexander Romanov
// Avatar.swift, created on 24.09.2020
//

import SwiftUI

public enum AvatarBackgroundType {
    case color(Color)
    case gradient([Color])
}

/// View that represents the avatar.
///
/// ```swift
/// Avatar(firstName: "Swift", lastName: "Apple")
/// ```
///
/// ```swift
/// Avatar(avatar: Image("Avatar"))
///     .controlSize(.large)
/// ```
///
public struct Avatar: View {
    #if !os(tvOS)
    @Environment(\.controlSize) var controlSize: ControlSize
    #endif

    /// The first name text of the avatar.
    let firstName: String?

    /// The last name text of the avatar.
    let lastName: String?

    /// The image used in the avatar content.
    let avatar: Image?

    /// The icon used in the avatar content.
    let icon: Image?

    /// Sets a  stroke color for the Avatar.
    var strokeColor: Color = .clear

    /// Sets a  stroke width for the Avatar.
    var strokeLineWidth: CGFloat = 2

    /// Sets a custom background color for the Avatar.
    var background: AvatarBackgroundType = .color(.surfaceSecondary)

    /// Sets a custom text and image color for the Avatar.
    var onBackgroundColor: Color = .onSurfaceMediumEmphasis

    /// Creates and initializes a Avatar
    /// - Parameters:
    ///   - firstName: The first name text used to calculate the Avatar initials.
    ///   - lastName: The last name text used to calculate the Avatar initials
    ///   - avatar: The optional image that the avatar should display.
    ///   - icon: The optional icon that the avatar should display.
    public init(
        firstName: String? = nil,
        lastName: String? = nil,
        avatar: Image? = nil,
        icon: Image? = nil
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
        self.icon = icon
    }

    public var body: some View {
        #if os(tvOS)
        tvOSContent
        #else
        content
        #endif
    }

    @available(tvOS, unavailable)
    @ViewBuilder
    private var content: some View {
        if let avatar {
            avatar
                .resizable()
                .scaledToFill()
                .frame(width: avatarSize, height: avatarSize)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(
                        strokeColor,
                        lineWidth: strokeLineWidth
                    )
                )

        } else {
            ZStack {
                avatarSurface
                    .frame(width: avatarSize, height: avatarSize)
                    .overlay(
                        Circle().stroke(
                            strokeColor,
                            lineWidth: strokeLineWidth
                        )
                    )

                avatarLabel
            }
        }
    }

    @available(iOS, unavailable)
    @available(watchOS, unavailable)
    @available(macOS, unavailable)
    @ViewBuilder
    private var tvOSContent: some View {
        if let avatar {
            avatar
                .resizable()
                .scaledToFill()
                .frame(width: Space.xxxLarge.rawValue, height: Space.xxxLarge.rawValue)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(
                        strokeColor,
                        lineWidth: strokeLineWidth
                    )
                )

        } else {
            ZStack {
                avatarSurface
                    .frame(width: Space.xxxLarge.rawValue, height: Space.xxxLarge.rawValue)
                    .overlay(
                        Circle().stroke(
                            strokeColor,
                            lineWidth: strokeLineWidth
                        )
                    )
            }
        }
    }

    @ViewBuilder
    private var avatarSurface: some View {
        switch background {
        case let .color(color):
            Circle()
                .fill(color)
        case let .gradient(gradientColors):
            Circle()
                .fill(LinearGradient(colors: gradientColors, startPoint: .topLeading, endPoint: .bottom))
        }
    }

    @available(tvOS, unavailable)
    @ViewBuilder
    private var avatarLabel: some View {
        HStack(spacing: avatarTextSpace) {
            if let icon {
                icon
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
            } else {
                if let firstName, !firstName.isEmpty {
                    Text(String(firstName.dropLast(firstName.count - 1)).capitalized)
                        .bold()
                }

                if let lastName, !lastName.isEmpty {
                    Text(String(lastName.dropLast(lastName.count - 1)).capitalized)
                        .bold()
                }
            }
        }
        .font(avatarTextFont)
        .foregroundColor(onBackgroundColor)
    }

    private var avatarTextFont: Font {
        #if os(tvOS)
        return .largeTitle
        #else
        switch controlSize {
        case .mini:
            return .caption
        case .small:
            return .subheadline
        case .regular:
            return .title3
        case .large, .extraLarge:
            return .largeTitle
        @unknown default:
            return .title2
        }
        #endif
    }

    private var avatarTextSpace: CGFloat {
        #if os(tvOS)
        return 2
        #else
        switch controlSize {
        case .mini:
            return 0
        case .small:
            return 1
        case .regular:
            return 2
        case .large, .extraLarge:
            return 2
        @unknown default:
            return 0
        }
        #endif
    }

    private var avatarSize: CGFloat {
        #if os(tvOS)
        return Space.xLarge.rawValue
        #else
        switch controlSize {
        case .mini:
            return Space.medium.rawValue
        case .small:
            return Space.large.rawValue
        case .regular:
            return Space.xLarge.rawValue
        case .large, .extraLarge:
            return Space.xxxLarge.rawValue
        @unknown default:
            return Space.xLarge.rawValue
        }
        #endif
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        AvatarPreview()
            .previewComponent("Avatar")
    }
}

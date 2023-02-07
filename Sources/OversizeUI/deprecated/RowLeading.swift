//
// Copyright © 2022 Alexander Romanov
// RowLeading.swift
//

import SwiftUI

public enum RowLeadingType {
    case icon(_ name: IconsNames)
    case iconOnSurface(_ name: IconsNames)
    case image(_ image: Image, color: Color? = .onSurfaceHighEmphasis)
    case imageOnSurface(_ image: Image, color: Color? = nil)
    case systemImage(_ imageName: String)
    case avatar(_ avatar: AvatarView)

    @available(*, deprecated, message: "Use leading: {}")
    case view(_ view: AnyView)
}

internal struct RowLeading: View {
    private let type: RowLeadingType
    private let isShowSubtitle: Bool
    private let iconBackgroundColor: Color?

    internal init(_ type: RowLeadingType, isShowSubtitle: Bool = false, iconBackgroundColor: Color? = nil) {
        self.type = type
        self.isShowSubtitle = isShowSubtitle
        self.iconBackgroundColor = iconBackgroundColor
    }

    internal var body: some View {
        switch type {
        case let .icon(icon):
            Icon(icon)

        case let .image(image, color):
            image
                .renderingMode(color != nil ? .template : .original)
                .resizable()
                .scaledToFill()
                .foregroundColor(color)
                .frame(width: isShowSubtitle ? 48 : 24, height: isShowSubtitle ? 48 : 24)
                .cornerRadius(isShowSubtitle ? 4 : 2)

        case let .avatar(avatar):
            avatar

        case let .iconOnSurface(icon):
            Surface {
                Icon(icon)
            }
            .surfaceStyle(.secondary)
            .surfaceBackgroundColor(iconBackgroundColor)
            .surfaceContentInsets(.xxSmall)

        case let .imageOnSurface(image, color):
            Surface {
                image
                    .renderingMode(.template)
                    .foregroundColor(color)
            }
            .surfaceStyle(.secondary)
            .surfaceBackgroundColor(iconBackgroundColor)
            .surfaceContentInsets(.xxSmall)

        case let .systemImage(systemImage):
            Image(systemName: systemImage)
                .foregroundColor(Color.onBackgroundHighEmphasis)
                .font(.system(size: 24))
                .frame(width: 24, height: 24, alignment: .center)

        case let .view(view):
            view
        }
    }
}

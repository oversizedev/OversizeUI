//
// Copyright © 2021 Alexander Romanov
// RowLeading.swift, created on 23.12.2022
//

import SwiftUI

public enum RowLeadingType {
    case icon(_ name: IconsNames)
    case iconOnSurface(_ name: IconsNames)
    case image(_ image: Image, color: Color? = .onSurfaceHighEmphasis)
    case imageOnSurface(_ image: Image, color: Color? = nil)
    case systemImage(_ imageName: String)
    case avatar(_ avatar: Avatar)

    @available(*, deprecated, message: "Use leading: {}")
    case view(_ view: AnyView)
}

struct RowLeading: View {
    private let type: RowLeadingType
    private let isShowSubtitle: Bool
    private let iconBackgroundColor: Color?

    init(_ type: RowLeadingType, isShowSubtitle: Bool = false, iconBackgroundColor: Color? = nil) {
        self.type = type
        self.isShowSubtitle = isShowSubtitle
        self.iconBackgroundColor = iconBackgroundColor
    }

    var body: some View {
        switch type {
        case let .icon(icon):
            IconDeprecated(icon)

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
                IconDeprecated(icon)
            }
            .surfaceStyle(.secondary)
            .surfaceBackgroundColor(iconBackgroundColor)
            .surfaceContentMargins(.xxSmall)

        case let .imageOnSurface(image, color):
            Surface {
                image
                    .renderingMode(.template)
                    .foregroundColor(color)
            }
            .surfaceStyle(.secondary)
            .surfaceBackgroundColor(iconBackgroundColor)
            .surfaceContentMargins(.xxSmall)

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

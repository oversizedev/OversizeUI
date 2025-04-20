//
// Copyright © 2021 Alexander Romanov
// Icon.swift, created on 13.09.2020
//

import SwiftUI

public enum IconSizes: CaseIterable {
    case xSmall
    case small
    case medium
    case large
    case xLarge

    public var rawValue: CGFloat {
        switch self {
        case .xSmall:
            Space.xSmall.rawValue
        case .small:
            Space.small.rawValue
        case .medium:
            #if os(macOS)
                20
            #else
                Space.medium.rawValue
            #endif
        case .large:
            Space.large.rawValue
        case .xLarge:
            Space.xLarge.rawValue
        }
    }
}

public struct IconDeprecated: View {
    private enum Constants: Sendable {
        /// Size
        static let xSmall: CGFloat = Space.xSmall.rawValue
        static let small: CGFloat = Space.small.rawValue
        static let medium: CGFloat = Space.medium.rawValue
        static let large: CGFloat = Space.large.rawValue
        static let xLarge: CGFloat = Space.xLarge.rawValue
    }

    let name: IconsNames?
    let image: Image?
    let size: IconSizes
    var color: Color

    public init(_ image: Image) {
        self.image = image
        size = .medium
        color = Color.onBackgroundPrimary
        name = nil
    }

    public init(_ name: IconsNames = .menu) {
        self.name = name
        size = .medium
        color = Color.onBackgroundPrimary
        image = nil
    }

    public init(_ name: IconsNames = .menu, size: IconSizes = .medium, color: Color = .onBackgroundPrimary) {
        self.name = name
        self.color = color
        self.size = size
        image = nil
    }

    public var body: some View {
        Image(name?.rawValue ?? "", bundle: .module)
            .renderingMode(.template)
            .resizable()
            .frame(width: iconSize, height: iconSize)
            .foregroundColor(color)
    }

    private var iconSize: CGFloat {
        switch size {
        case .xSmall:
            Constants.xSmall
        case .small:
            Constants.small
        case .medium:
            Constants.medium
        case .large:
            Constants.large
        case .xLarge:
            Constants.xLarge
        }
    }

    public func iconColor(_ color: Color) -> IconDeprecated {
        var control = self
        control.color = color
        return control
    }
}

@available(tvOS, unavailable)
struct IconAsset_Previews: PreviewProvider {
    static var previews: some View {
        let grid = [
            GridItem(),
            GridItem(),
            GridItem(),
            GridItem(),
            GridItem(),
            GridItem(),
        ]

        Button(role: .cancel, action: {}, label: {
            Text("Text")
        })
        .buttonStyle(.borderedProminent)
        .controlSize(.large)

        LazyVGrid(columns: grid) {
            ForEach(IconsNames.allCases, id: \.self) { icon in
                IconDeprecated(icon)
                    .padding(.vertical)
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

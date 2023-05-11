//
// Copyright © 2021 Alexander Romanov
// Icon.swift, created on 13.09.2020
//

import SwiftUI

public enum IconSizes: CaseIterable {
    case small
    case medium
    case large
    case xLarge

    public var rawValue: CGFloat {
        switch self {
        case .small:
            return Space.small.rawValue
        case .medium:
            return Space.medium.rawValue
        case .large:
            return Space.large.rawValue
        case .xLarge:
            return Space.xLarge.rawValue
        }
    }
}

public struct IconDeprecated: View {
    private enum Constants {
        /// Size
        static var small: CGFloat = Space.small.rawValue
        static var medium: CGFloat = Space.medium.rawValue
        static var large: CGFloat = Space.large.rawValue
        static var xLarge: CGFloat = Space.xLarge.rawValue
    }

    let name: IconsNames?
    let image: Image?
    let size: IconSizes
    var color: Color

    public init(_ image: Image) {
        self.image = image
        size = .medium
        color = Color.onBackgroundHighEmphasis
        name = nil
    }

    public init(_ name: IconsNames = .menu) {
        self.name = name
        size = .medium
        color = Color.onBackgroundHighEmphasis
        image = nil
    }

    public init(_ name: IconsNames = .menu, size: IconSizes = .medium, color: Color = .onBackgroundHighEmphasis) {
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
        case .medium:
            return Constants.medium
        case .small:
            return Constants.small
        case .large:
            return Constants.large
        case .xLarge:
            return Constants.xLarge
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
        let grid = [GridItem(),
                    GridItem(),
                    GridItem(),
                    GridItem(),
                    GridItem(),
                    GridItem()]

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

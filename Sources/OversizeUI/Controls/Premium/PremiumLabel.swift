//
// Copyright © 2021 Alexander Romanov
// PremiumLabel.swift, created on 06.12.2021
//

import SwiftUI

public enum PrmiumLabelSize {
    case small, medium
}

public struct PremiumLabel: View {
    private let image: Image?
    private let text: String
    private let size: PrmiumLabelSize
    private var isMonohrom = false

    public init(text: String = "Pro", size: PrmiumLabelSize = .medium) {
        self.text = text
        self.size = size
        image = nil
    }

    public init(image: Image, text: String = "Pro", size: PrmiumLabelSize = .medium) {
        self.text = text
        self.size = size
        self.image = image
    }

    public var body: some View {
        HStack {
            HStack(alignment: .center, spacing: Space.xxSmall) {
                if let image {
                    image
                        .renderingMode(.template)
                        .foregroundColor(isMonohrom ? Color(red: 0.718, green: 0.325, blue: 0.459) : .onPrimaryHighEmphasis)
                }
                Text(text)
                    .font(.system(size: fontSize, weight: .heavy))
                    .foregroundColor(isMonohrom ? Color(red: 0.718, green: 0.325, blue: 0.459) : .onPrimaryHighEmphasis)
            }
            .padding(.leading, leadingPadding)
            .padding(.trailing, trailingPadding)
            .padding(.vertical, verticalPadding)
        }
        .background {
            Group {
                if isMonohrom {
                    RoundedRectangle(cornerRadius: radius, style: .continuous)
                        .fill(Color.onPrimaryHighEmphasis)
                } else {
                    RoundedRectangle(cornerRadius: radius, style: .continuous)
                        .fill(LinearGradient(gradient: Gradient(colors: [
                                Color(red: 0.918, green: 0.671, blue: 0.267),
                                Color(red: 0.824, green: 0.29, blue: 0.267),
                                Color(red: 0.612, green: 0.357, blue: 0.635),
                                Color(red: 0.294, green: 0.357, blue: 0.58),
                            ]),
                            startPoint: .topLeading, endPoint: .bottomTrailing))
                }
            }
        }
    }

    var fontSize: CGFloat {
        switch size {
        case .small:
            12
        case .medium:
            20
        }
    }

    var leadingPadding: Space {
        switch size {
        case .small:
            Space.xxSmall
        case .medium:
            Space.xSmall
        }
    }

    var trailingPadding: Space {
        switch size {
        case .small:
            image == .none ? .xxSmall : .xSmall
        case .medium:
            image == .none ? .xSmall : .small
        }
    }

    var verticalPadding: Space {
        switch size {
        case .small:
            Space.xxxSmall
        case .medium:
            Space.xxSmall
        }
    }

    var radius: Radius {
        switch size {
        case .small:
            Radius.small
        case .medium:
            Radius.medium
        }
    }

    public func monochrom(isMonohrom: Bool = true) -> PremiumLabel {
        var control = self
        control.isMonohrom = isMonohrom
        return control
    }
}

struct PrmiumLabel_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PremiumLabel(size: .small)
            PremiumLabel()
        }
    }
}

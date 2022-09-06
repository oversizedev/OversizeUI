//
// Copyright © 2022 Alexander Romanov
// PremiumLabel.swift
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
                if let image = image {
                    image
                        .renderingMode(.template)
                        .foregroundColor(isMonohrom ? Color(hex: "B75375") : .onPrimaryHighEmphasis)
                }
                Text(text)
                    .font(.system(size: fontSize, weight: .heavy))
                    .foregroundColor(isMonohrom ? Color(hex: "B75375") : .onPrimaryHighEmphasis)
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
                        .fill(LinearGradient(gradient: Gradient(
                                colors: [Color(hex: "EAAB44"),
                                         Color(hex: "D24A44"),
                                         Color(hex: "9C5BA2"),
                                         Color(hex: "4B5B94")]),
                            startPoint: .topLeading, endPoint: .bottomTrailing))
                }
            }
        }
    }

    var fontSize: CGFloat {
        switch size {
        case .small:
            return 12
        case .medium:
            return 20
        }
    }

    var leadingPadding: Space {
        switch size {
        case .small:
            return Space.xxSmall
        case .medium:
            return Space.xSmall
        }
    }

    var trailingPadding: Space {
        switch size {
        case .small:
            return image == .none ? .xxSmall : .xSmall
        case .medium:
            return image == .none ? .xSmall : .small
        }
    }

    var verticalPadding: Space {
        switch size {
        case .small:
            return Space.xxxSmall
        case .medium:
            return Space.xxSmall
        }
    }

    var radius: Radius {
        switch size {
        case .small:
            return Radius.small
        case .medium:
            return Radius.medium
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

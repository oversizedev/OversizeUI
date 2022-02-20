//
// Copyright © 2022 Alexander Romanov
// PremiumLabel.swift
//

import SwiftUI

public enum PrmiumLabelSize {
    case small, medium
}

public struct PremiumLabel: View {
    let text: String
    let size: PrmiumLabelSize

    public init(text: String = "Pro", size: PrmiumLabelSize = .medium) {
        self.text = text
        self.size = size
    }

    public var body: some View {
        HStack {
            HStack(alignment: .center, spacing: Space.xxSmall) {
                Text(text)
                    .font(.system(size: fontSize, weight: .heavy))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
        }
        .background(
            RoundedRectangle(cornerRadius: radius.rawValue, style: .continuous)
                .fill(LinearGradient(gradient: Gradient(
                        colors: [Color(hex: "EAAB44"),
                                 Color(hex: "D24A44"),
                                 Color(hex: "9C5BA2"),
                                 Color(hex: "4B5B94")]),
                    startPoint: .topLeading, endPoint: .bottomTrailing))
        )
    }

    var fontSize: CGFloat {
        switch size {
        case .small:
            return 12
        case .medium:
            return 20
        }
    }

    var horizontalPadding: Space {
        switch size {
        case .small:
            return Space.xxSmall
        case .medium:
            return Space.xSmall
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
}

struct PrmiumLabel_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PremiumLabel(size: .small)

            PremiumLabel()
        }
    }
}

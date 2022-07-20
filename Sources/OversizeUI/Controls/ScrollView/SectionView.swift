//
// Copyright © 2022 Alexander Romanov
// SectionView.swift
//

import SwiftUI

public struct SectionView<Content: View>: View {
    private let content: Content
    private let title: String
    private let verticalPadding: Space

    public init(_ title: String = "", verticalPadding: Space = .xxSmall, @ViewBuilder content: () -> Content) {
        self.title = title
        self.verticalPadding = verticalPadding
        self.content = content()
    }

    private enum Constants {
        /// Radius
        static var radiusMedium: CGFloat { Radius.medium.rawValue }
        static var radiusSmall: CGFloat { Radius.small.rawValue }
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: Space.xSmall.rawValue) {
            if title != "" {
                Text(title)
                    .fontStyle(.headline)
                    .foregroundColor(.onBackgroundHighEmphasis)
                    .padding(.leading, .xxxSmall)
            }

            Surface {
                content
                    .padding(.vertical, verticalPadding)
            }
            .controlPadding(.zero)
            .clipShape(
                RoundedRectangle(cornerRadius: Constants.radiusMedium,
                                 style: .circular)
            )
        }
        .paddingContent(.horizontal)
        .padding(.vertical, Space.small)
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: .zero) {
            SectionView("App") {
                Row("Label", leadingType: .icon(.user), paddingHorizontal: .medium)
            }

            SectionView("Feedback") {
                VStack(spacing: .zero) {
                    Row("Label", leadingType: .icon(.user), paddingHorizontal: .medium)
                    Row("Label", leadingType: .icon(.user), paddingHorizontal: .medium)
                }
            }

            Spacer()
        }
        .background(Color.backgroundSecondary.ignoresSafeArea(.all))
    }
}

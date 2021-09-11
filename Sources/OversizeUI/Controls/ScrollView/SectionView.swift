//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public struct SectionView<Content: View>: View {
    private let content: Content
    private let title: String

    public init(_ title: String = "", @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: Space.xSmall.rawValue) {
            if title != "" {
                Text(title)
                    .fontStyle(.subtitle1)
                    .foregroundColor(.onBackgroundHighEmphasis)
            }

            Surface(padding: .zero) {
                content
                    .padding(.vertical, Space.xxSmall)
            }
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

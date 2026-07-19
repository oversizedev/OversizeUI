//
// Copyright © 2026 Alexander Romanov
// LayoutSectionView.swift, created on 24.06.2026
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
struct LayoutSectionView: View {
    @Environment(\.sectionTitleSeparator) private var titleSeparator
    @Environment(\.isBordered) private var isBordered
    @Environment(\.sectionTitlePosition) private var sectionTitlePosition
    @Environment(\.sectionContentMarginsVisibility) private var sectionContentMarginsVisibility

    let section: SectionConfiguration
    let isFirst: Bool
    let isStacked: Bool

    var body: some View {
        VStack(spacing: .zero) {
            if sectionTitlePosition == .outside, section.header.count > 0 {
                LayoutSectionHeaderView(header: section.header)
                    .padding(.top, isFirst ? .zero : .xSmall)
            }

            VStack(spacing: .zero) {
                if sectionTitlePosition == .inside, section.header.count > 0 {
                    LayoutSectionHeaderView(header: section.header)
                        .padding(.horizontal, isStacked ? .xxxSmall : .zero)

                    if titleSeparator == .visible, sectionContentMarginsVisibility != .visible {
                        Separator()
                    }
                }

                VStack(spacing: .zero) {
                    ForEach(section.content) { subview in
                        subview
                            .overlay(alignment: .bottom) {
                                if section.content.last?.id != subview.id {
                                    Separator()
                                }
                            }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, .xxSmall)
                .clipShape(RoundedRectangle(
                    cornerRadius: .regular,
                    style: .continuous
                ))
                .if(sectionContentMarginsVisibility == .visible) {
                    $0
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                            .strokeBorder(
                                Color.border.opacity(isBordered ? 1 : 0),
                                lineWidth: 1
                            )
                        )
                        .padding(
                            .init(
                                top: section.header.count < 1 ? .xxxSmall : titleSeparator == .visible ? .xxxSmall : .zero,
                                leading: sectionContentMarginsVisibility == .visible ? .xxxSmall : 0,
                                bottom: sectionContentMarginsVisibility == .visible ? .xxxSmall : 0,
                                trailing: sectionContentMarginsVisibility == .visible ? .xxxSmall : 0
                            )
                        )
                }

                if section.footer.count > 0 {
                    if isBordered, sectionContentMarginsVisibility != .visible {
                        Separator()
                    }

                    section.footer
                }
            }
            .background {
                if isStacked {
                    LayoutSectionBackgroundView()
                }
            }
        }
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
struct LayoutSectionHeaderView<Header: View>: View {
    @Environment(\.sectionTitleMargins) private var sectionTitleInsets: SwiftUI.EdgeInsets
    @Environment(\.headerProminence) private var headerProminence

    let header: Header

    var body: some View {
        header
            .font(headerProminence == .increased ? .title3.weight(.semibold) : .headline.weight(.semibold))
            .foregroundStyle(Color.onBackgroundPrimary)
            .padding(sectionTitleInsets)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
struct LayoutSectionBackgroundView: View {
    @Environment(\.isBordered) private var isBordered

    var body: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(Color.surfacePrimary)
            .clipShape(RoundedRectangle(
                cornerRadius: 20,
                style: .continuous
            ))
            .overlay(
                RoundedRectangle(
                    cornerRadius: 24,
                    style: .continuous
                )
                .strokeBorder(
                    Color.border.opacity(isBordered ? 1 : 0),
                    lineWidth: 1
                )
            )
    }
}

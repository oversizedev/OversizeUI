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
    let isLast: Bool
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
                // .padding(.vertical, .xxSmall)
                #if os(macOS)
                    .clipShape(RoundedRectangle(
                        cornerRadius: .xSmall,
                        style: .continuous
                    ))
                #else
                    .clipShape(RoundedRectangle(
                        cornerRadius: .regular,
                        style: .continuous
                    ))
                #endif
                    .if(sectionContentMarginsVisibility == .visible) {
                        $0
                        #if os(macOS)
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: .xSmall,
                                style: .continuous
                            )
                            .strokeBorder(
                                Color.border.opacity(isBordered ? 1 : 0),
                                lineWidth: 1
                            )
                        )
                        #else
                        .overlay(
                                RoundedRectangle(
                                    cornerRadius: .regular,
                                    style: .continuous
                                )
                                .strokeBorder(
                                    Color.border.opacity(isBordered ? 1 : 0),
                                    lineWidth: 1
                                )
                            )
                        #endif
                            .padding(
                                .init(
                                    top: section.header.count < 1 ? .xxxSmall : titleSeparator == .visible && section.header.count < 1 ? .xxxSmall : .zero,
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
        #if os(macOS)
        .padding(
            .init(
                top: isFirst ? .small : .zero,
                leading: .zero,
                bottom: isLast ? .small : .zero,
                trailing: .zero
            )
        )
        #else
        .padding(
                .init(
                    top: isFirst ? .xxSmall : .zero,
                    leading: .zero,
                    bottom: isLast ? .xxSmall : .zero,
                    trailing: .zero
                )
            )
        #endif
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

    #if os(macOS)
    var body: some View {
        RoundedRectangle(cornerRadius: .xSmall)
            .fill(Color.surfacePrimary)
            .clipShape(RoundedRectangle(
                cornerRadius: .regular,
                style: .continuous
            ))
            .overlay(
                RoundedRectangle(
                    cornerRadius: .small,
                    style: .continuous
                )
                .strokeBorder(
                    Color.border.opacity(isBordered ? 1 : 0),
                    lineWidth: 1
                )
            )
    }
    #else
    var body: some View {
        RoundedRectangle(cornerRadius: .medium)
            .fill(Color.surfacePrimary)
            .clipShape(RoundedRectangle(
                cornerRadius: .regular,
                style: .continuous
            ))
            .overlay(
                RoundedRectangle(
                    cornerRadius: .medium,
                    style: .continuous
                )
                .strokeBorder(
                    Color.border.opacity(isBordered ? 1 : 0),
                    lineWidth: 1
                )
            )
    }
    #endif
}

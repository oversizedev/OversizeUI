//
// Copyright © 2026 Alexander Romanov
// LayoutSectionView.swift, created on 24.06.2026
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
struct LayoutSectionView: View {
    @Environment(\.self) private var environment
    @Environment(\.listLayoutStyle) private var listStyle: ListLayoutStyle

    let section: SectionConfiguration
    let isFirst: Bool
    let isLast: Bool
    let isStacked: Bool

    private var style: ResolvedSectionStyle {
        section.resolvedStyle(environment: environment)
    }

    private var titleSeparator: Visibility {
        style.titleSeparator
    }

    private var isBordered: Bool {
        style.isBordered
    }

    private var sectionTitlePosition: SectionTitlePosition {
        style.titlePosition
    }

    private var sectionContentMarginsVisibility: Visibility {
        style.contentMarginsVisibility
    }

    private var backgroundStyle: SectionBackgroundStyle {
        style.backgroundStyle
    }

    private var sectionHorizontalMargins: CGFloat {
        switch listStyle {
        case .plain, .inset, .grouped:
            .zero
        case .insetGrouped:
            .medium
        case .smallInsetGrouped:
            .xxSmall
        }
    }

    var body: some View {
        VStack(spacing: .zero) {
            if sectionTitlePosition == .outside, section.header.count > 0 {
                LayoutSectionHeaderView(header: section.header, margins: style.titleMargins)
                    .padding(.top, isFirst ? .zero : .xSmall)
            }

            VStack(spacing: .zero) {
                if sectionTitlePosition == .inside, section.header.count > 0 {
                    LayoutSectionHeaderView(header: section.header, margins: style.titleMargins)

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
                    LayoutSectionBackgroundView(
                        style: backgroundStyle,
                        isBordered: isBordered
                    )
                }
            }
        }
        .padding(.horizontal, sectionHorizontalMargins)
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
    @Environment(\.headerProminence) private var headerProminence

    let header: Header
    let margins: SwiftUI.EdgeInsets

    var body: some View {
        header
            .font(headerProminence == .increased ? .title3.weight(.semibold) : .headline.weight(.semibold))
            .foregroundStyle(Color.onBackgroundPrimary)
            .padding(margins)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
struct LayoutSectionBackgroundView: View {
    let style: SectionBackgroundStyle
    let isBordered: Bool

    private var borderRadius: CGFloat {
        #if os(macOS)
        .small
        #else
        .medium
        #endif
    }

    var body: some View {
        switch style {
        case .surface:
            surfaceBackground
        case .dotted:
            Color.clear
                .dottedBorder(cornerRadius: borderRadius)
        case .plain:
            EmptyView()
        }
    }

    #if os(macOS)
    private var surfaceBackground: some View {
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
    private var surfaceBackground: some View {
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

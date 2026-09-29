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
        switch listStyle {
        case .plain, .inset:
            section.containerValues.sectionBackgroundStyle ?? environment.explicitSectionBackgroundStyle ?? .plain
        case .grouped, .insetGrouped, .smallInsetGrouped:
            style.backgroundStyle
        }
    }

    private var isCardVisible: Bool {
        backgroundStyle != .plain
    }

    private var isRounded: Bool {
        switch listStyle {
        case .plain, .inset, .grouped:
            false
        case .insetGrouped, .smallInsetGrouped:
            true
        }
    }

    private var contentCornerRadius: CGFloat {
        guard isRounded else { return .zero }
        #if os(macOS)
        return .xSmall
        #else
        return .regular
        #endif
    }

    private var sectionHorizontalMargins: CGFloat {
        switch listStyle {
        case .plain, .inset, .grouped:
            .zero
        case .insetGrouped:
            .medium
        case .smallInsetGrouped:
            #if os(macOS)
            .small
            #else
            .xxSmall
            #endif
        }
    }

    private var sectionVerticalMargins: CGFloat {
        switch listStyle {
        case .plain, .inset:
            .zero
        case .grouped, .insetGrouped, .smallInsetGrouped:
            #if os(macOS)
            .small
            #else
            .xxSmall
            #endif
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
                .clipShape(RoundedRectangle(
                    cornerRadius: isCardVisible ? contentCornerRadius : .zero,
                    style: .continuous
                ))
                .if(sectionContentMarginsVisibility == .visible) {
                    $0
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: contentCornerRadius,
                                style: .continuous
                            )
                            .strokeBorder(
                                Color.border.opacity(isBordered ? 1 : 0),
                                lineWidth: 1
                            )
                        )
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
                    if isBordered, isCardVisible, sectionContentMarginsVisibility != .visible {
                        Separator()
                    }

                    section.footer
                }
            }
            .background {
                LayoutSectionBackgroundView(
                    style: backgroundStyle,
                    isBordered: isBordered,
                    isRounded: isRounded
                )
            }
        }
        .padding(.horizontal, sectionHorizontalMargins)
        .padding(
            .init(
                top: isFirst ? sectionVerticalMargins : .zero,
                leading: .zero,
                bottom: isLast ? sectionVerticalMargins : .zero,
                trailing: .zero
            )
        )
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
    let isRounded: Bool

    private var borderRadius: CGFloat {
        #if os(macOS)
        cornerRadius(.small)
        #else
        cornerRadius(.medium)
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

    private func cornerRadius(_ radius: CGFloat) -> CGFloat {
        isRounded ? radius : .zero
    }

    #if os(macOS)
    private var surfaceBackground: some View {
        RoundedRectangle(cornerRadius: cornerRadius(.xSmall))
            .fill(Color.surfacePrimary)
            .clipShape(RoundedRectangle(
                cornerRadius: cornerRadius(.regular),
                style: .continuous
            ))
            .overlay(
                RoundedRectangle(
                    cornerRadius: cornerRadius(.small),
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
        RoundedRectangle(cornerRadius: cornerRadius(.medium))
            .fill(Color.surfacePrimary)
            .clipShape(RoundedRectangle(
                cornerRadius: cornerRadius(.regular),
                style: .continuous
            ))
            .overlay(
                RoundedRectangle(
                    cornerRadius: cornerRadius(.medium),
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

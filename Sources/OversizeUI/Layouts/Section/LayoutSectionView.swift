//
// Copyright © 2026 Alexander Romanov
// LayoutSectionView.swift, created on 24.06.2026
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
struct LayoutSectionView: View {
    @Environment(\.listLayoutStyle) private var listStyle: ListLayoutStyle
    @Environment(\.sectionTitlePosition) private var defaultTitlePosition
    @Environment(\.isBordered) private var legacyIsBordered
    @Environment(\.isSectionBordered) private var defaultIsBordered
    @Environment(\.sectionTitleSeparator) private var defaultTitleSeparator
    @Environment(\.sectionContentMarginsVisibility) private var defaultContentMarginsVisibility
    @Environment(\.sectionTitleMargins) private var defaultTitleMargins
    @Environment(\.sectionBackgroundStyle) private var defaultBackgroundStyle
    @Environment(\.explicitSectionBackgroundStyle) private var explicitBackgroundStyle
    @Environment(\.sectionRowsPaddingVisibility) private var defaultRowsPaddingVisibility

    let section: SectionConfiguration
    let isFirst: Bool
    let isLast: Bool

    var body: some View {
        VStack(spacing: .zero) {
            if titlePosition == .outside, section.header.count > 0 {
                LayoutSectionHeaderView(header: section.header, margins: titleMargins)
                    .padding(.top, isFirst ? .zero : .xSmall)
            }

            card

            if titlePosition == .outside, section.footer.count > 0 {
                LayoutSectionFooterView(footer: section.footer, margins: titleMargins, color: .onBackgroundSecondary)
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

    private var card: some View {

        return VStack(spacing: .zero) {
            if titlePosition == .inside, section.header.count > 0 {
                LayoutSectionHeaderView(header: section.header, margins: titleMargins)

                if titleSeparator == .visible, contentMarginsVisibility != .visible {
                    Separator()
                }
            }

            LazyVStack(spacing: .zero) {
                sectionRows
            }
            .padding(.vertical, (rowsPaddingVisibility == .visible || rowsPaddingVisibility == .automatic && !isBordered) ? .xxSmall : .zero)
            .frame(maxWidth: .infinity, alignment: .leading)
            .clipShape(RoundedRectangle(
                cornerRadius: backgroundStyle != .plain ? contentCornerRadius : .zero,
                style: .continuous
            ))
            .if(contentMarginsVisibility == .visible) {
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
                            top: section.header.count == 0 ? .xxxSmall : .zero,
                            leading: .xxxSmall,
                            bottom: .xxxSmall,
                            trailing: .xxxSmall
                        )
                    )
            }

            if titlePosition == .inside, section.footer.count > 0 {
                if titleSeparator == .visible, contentMarginsVisibility != .visible {
                    Separator()
                }

                LayoutSectionFooterView(footer: section.footer, margins: titleMargins, color: .onSurfaceSecondary)
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

    private var sectionRows: some View {
        let lastID = section.content.last?.id
        return ForEach(section.content) { subview in
            subview
                .overlay(alignment: .bottom) {
                    if isBordered, lastID != subview.id {
                        Separator()
                    }
                }
        }
    }

    // MARK: - Style

    private var titlePosition: SectionTitlePosition {
        section.containerValues.sectionTitlePosition ?? defaultTitlePosition
    }

    private var isBordered: Bool {
        section.containerValues.isSectionBordered
            ?? section.containerValues.isBordered
            ?? (defaultIsBordered || legacyIsBordered)
    }

    private var titleSeparator: Visibility {
        section.containerValues.sectionTitleSeparator ?? defaultTitleSeparator
    }

    private var contentMarginsVisibility: Visibility {
        section.containerValues.sectionContentMarginsVisibility ?? defaultContentMarginsVisibility
    }

    private var titleMargins: SwiftUI.EdgeInsets {
        section.containerValues.sectionTitleMargins ?? defaultTitleMargins
    }

    private var rowsPaddingVisibility: Visibility {
        section.containerValues.sectionRowsPaddingVisibility ?? defaultRowsPaddingVisibility
    }

    private var backgroundStyle: SectionBackgroundStyle {
        let sectionBackgroundStyle = section.containerValues.sectionBackgroundStyle
        switch listStyle {
        case .plain, .inset:
            return sectionBackgroundStyle ?? explicitBackgroundStyle ?? .plain
        case .grouped, .insetGrouped, .smallInsetGrouped:
            return sectionBackgroundStyle ?? defaultBackgroundStyle
        }
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
struct LayoutSectionFooterView<Footer: View>: View {
    let footer: Footer
    let margins: SwiftUI.EdgeInsets
    let color: Color

    var body: some View {
        footer
            .font(.footnote)
            .foregroundStyle(color)
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

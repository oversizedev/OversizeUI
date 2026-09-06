//
// Copyright © 2026 Alexander Romanov
// LayoutSectionView.swift, created on 31.07.2026
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
struct ListLayoutSectionView: View {
    @Environment(\.self) private var environment
    @Environment(\.listLayoutStyle) private var listStyle: ListLayoutStyle

    let section: SectionConfiguration

    private var style: ResolvedSectionStyle {
        section.resolvedStyle(environment: environment)
    }

    private var titleSeparator: Visibility {
        style.titleSeparator
    }

    private var titlePosition: SectionTitlePosition {
        style.titlePosition
    }

    var body: some View {
        @ViewBuilder
        var sectionView: some View {
            #if os(iOS)
            if #available(iOS 26.0, *) {
                Section {
                    if section.header.count > 0, titlePosition == .inside {
                        section.header
                            .padding(titleSeparator == .hidden ? .top : .vertical, titleSeparator == .hidden ? .regular : .small)
                            .padding(.horizontal, .medium)
                            .listRowSeparator(titleSeparator, edges: .bottom)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                            .alignmentGuide(.listRowSeparatorTrailing) { d in d.width }
                    }
                    section.content
                } header: {
                    if section.header.count > 0, titlePosition == .outside {
                        section.header
                    }
                } footer: {
                    section.footer
                }
                .listSectionMargins(.horizontal, listSectionHorizontalMargins)

            } else {
                Section {
                    if section.header.count > 0, titlePosition == .inside {
                        section.header
                            .listRowSeparator(titleSeparator, edges: .bottom)
                    }
                    section.content
                } header: {
                    if section.header.count > 0, titlePosition == .outside {
                        section.header
                    }
                } footer: {
                    section.footer
                }
            }
            #else
            Section {
                if section.header.count > 0, titlePosition == .inside {
                    section.header
                        #if !os(watchOS) && !os(tvOS)
                        .listRowSeparator(.hidden)
                        #endif
                }
                section.content
            } header: {
                if section.header.count > 0, titlePosition == .outside {
                    section.header
                }
            } footer: {
                section.footer
            }
            #endif
        }
        return sectionView
    }

    var listSectionHorizontalMargins: CGFloat {
        switch listStyle {
        case .plain, .inset, .grouped:
            .zero
        case .insetGrouped:
            .medium
        case .smallInsetGrouped:
            .xxSmall
        }
    }
}

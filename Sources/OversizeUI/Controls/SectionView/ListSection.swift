//
// Copyright © 2026 Alexander Romanov
// ListSection.swift, created on 19.03.2026
//

import SwiftUI

public struct ListSection<SectionContent: View, SectionHeaderContent: View, SectionFooterContent: View>: View {
    @Environment(\.listLayoutStyle) private var listStyle: ListLayoutStyle
    @Environment(\.listSectionTitleSeparator) private var titleSeparator
    @Environment(\.sectionTitlePosition) private var titlePosition

    private var content: () -> SectionContent

    private var footer: (() -> SectionFooterContent)?

    private var header: (() -> SectionHeaderContent)?

    public init(
        @ViewBuilder content: @escaping () -> SectionContent,
        @ViewBuilder header: @escaping () -> SectionHeaderContent,
        @ViewBuilder footer: @escaping () -> SectionFooterContent
    ) {
        self.content = content
        self.header = header
        self.footer = footer
    }

    public var body: some View {
        @ViewBuilder
        var sectionView: some View {
            #if os(iOS)
            if #available(iOS 26.0, *) {
                Section {
                    if let header, titlePosition == .inside {
                        header()
                            .padding(titleSeparator == .hidden ? .top : .vertical, titleSeparator == .hidden ? .regular : .small)
                            .padding(.horizontal, .medium)
                            .listRowSeparator(titleSeparator, edges: .bottom)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                            .alignmentGuide(.listRowSeparatorTrailing) { d in d.width }
                    }
                    content()
                } header: {
                    if let header, titlePosition == .outside {
                        header()
                    }
                } footer: {
                    if let footer {
                        footer()
                    }
                }
                .listSectionMargins(.horizontal, listSectionHorizontalMargins)
            } else {
                Section {
                    if let header, titlePosition == .inside {
                        header()
                            .listRowSeparator(titleSeparator, edges: .bottom)
                    }
                    content()
                } header: {
                    if let header, titlePosition == .outside {
                        header()
                    }
                } footer: {
                    if let footer {
                        footer()
                    }
                }
            }
            #else
            Section {
                if let header, titlePosition == .inside {
                    header()
                    #if !os(watchOS)
                        .listRowSeparator(.hidden)
                    #endif
                }
                content()
            } header: {
                if let header, titlePosition == .outside {
                    header()
                }
            } footer: {
                if let footer {
                    footer()
                }
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

public extension ListSection where SectionHeaderContent == EmptyView, SectionFooterContent == EmptyView {
    init(@ViewBuilder content: @escaping () -> SectionContent) {
        self.content = content
    }
}

public extension ListSection where SectionFooterContent == EmptyView {
    init(@ViewBuilder content: @escaping () -> SectionContent, @ViewBuilder header: @escaping () -> SectionHeaderContent) {
        self.content = content
        self.header = header
    }
}

public extension ListSection where SectionHeaderContent == EmptyView {
    init(@ViewBuilder content: @escaping () -> SectionContent, @ViewBuilder footer: @escaping () -> SectionFooterContent) {
        self.content = content
        self.footer = footer
    }
}

public extension ListSection where SectionHeaderContent == ListSectionHeader<String, EmptyView>, SectionFooterContent == EmptyView {
    init(_ title: String, @ViewBuilder content: @escaping () -> SectionContent) {
        self.content = content
        header = { ListSectionHeader(title: title) }
    }
}

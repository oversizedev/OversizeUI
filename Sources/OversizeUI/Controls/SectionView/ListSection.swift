//
// Copyright © 2026 Alexander Romanov
// ListSection.swift, created on 19.03.2026
//

import SwiftUI

public struct ListSection<SectionContent: View, SectionHeaderContent: View, SectionFooterContent: View>: View {
    
    private var titlePosition: SectionViewTitlePosition = .outside
    
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
            Section {
                if let header = header, titlePosition == .inside {
                    header()
                        .listRowSeparator(.hidden)
                }
                content()
            } header: {
                if let header = header, titlePosition == .outside {
                    header()
                }
            } footer: {
                if let footer = footer {
                    footer()
                }
            }
        }
        return sectionView
    }
}

public extension ListSection {
    func sectionTitlePosition(_ position: SectionViewTitlePosition) -> ListSection {
        var control = self
        control.titlePosition = position
        return control
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
        self.header = { ListSectionHeader(title: title) }
    }
}

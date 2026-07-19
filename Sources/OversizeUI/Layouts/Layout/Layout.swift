//
// Copyright © 2026 Alexander Romanov
// Layout.swift, created on 07.06.2026
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public struct Layout<Content: View, Background: View>: View {
    public typealias ScrollAction = @MainActor @Sendable (_ offset: CGFloat, _ headerVisibleRatio: CGFloat) -> Void

    private let title: String
    private let onScroll: ScrollAction?
    @ViewBuilder private var content: Content
    @ViewBuilder private let background: Background

    @State private var headerHeight: CGFloat = 0

    public var body: some View {
        ScrollView {
            LazyVStack(spacing: .xxSmall) {
                Group(sections: content) { sections in
                    ForEach(sections) { section in
                        LayoutSectionView(
                            section: section,
                            isFirst: section.id == sections.first?.id,
                            isStacked: sections.count > 1
                        )
                    }
                }
            }
            .padding(.horizontal, .xxSmall)
        }
        .onScrollGeometryChange(for: CGFloat.self) { proxy in
            proxy.contentOffset.y + proxy.contentInsets.top
        } action: { _, value in
            updateScrollOffset(value)
        }
        .background {
            Color.backgroundSecondary.ignoresSafeArea()
        }
        .background {
            Color.clear
                .ignoresSafeArea()
                .onGeometryChange(for: CGFloat.self) { proxy in
                    proxy.safeAreaInsets.top + 44
                } action: { height in
                    let isInitial = headerHeight == 0
                    headerHeight = height
                    if isInitial {
                        onScroll?(.zero, 1.0)
                    }
                }
        }
    }

    private func updateScrollOffset(_ offset: CGFloat) {
        guard headerHeight > 0 else { return }
        let visibleRatio: CGFloat = (headerHeight - offset) / headerHeight
        onScroll?(offset, visibleRatio)
    }

    public init(
        _ title: String = "",
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder background: () -> Background = { Color.backgroundPrimary }
    ) {
        self.title = title
        self.onScroll = onScroll
        self.content = content()
        self.background = background()
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public struct LayoutSection<Content: View>: View {
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        Group(subviews: content) { subviews in
            VStack(alignment: .leading) {
                ForEach(subviews) { subview in
                    subview

                    if subviews.last?.id != subview.id {
                        Divider()
                            .padding(.vertical, 8)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 32))
        }
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
#Preview {
    NavigationStack {
        Layout {
            Section {
                Text("Song 1")
                    .padding()
                Text("Song 2")
                    .padding()
            }

            Section("Inside title") {
                Row("Song 1") {
                    print("")
                }
                Row("Song 2")
                Row("Song 3") {
                    print("")
                }
            }
            #if !os(tvOS)
            .sectionActions {
                Button("Action 1") {}
                Button("Action 2") {}
            }
            #endif

            Section("Person1’s Favorites") {
                Text("Song 1")
                Text("Song 2")
                Text("Song 3")
            }

            Section {
                Text("Song 1")
                Text("Song 2")
                Text("Song 3")
            } header: {
                Text("Title")
            } footer: {
                Text("Footer")
            }
        }
        .sectionTitlePosition(.inside)
        .bordered()
        .sectionTitleSeparator(.visible)
        // .headerProminence(.increased)
    }
}

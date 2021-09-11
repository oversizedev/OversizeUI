//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public enum NavigationBarStyleType {
    case system
    case fixed(_ offset: Binding<CGPoint>)
    case scroll(_ offset: Binding<CGPoint>)
}

// swiftlint:disable all
public extension View {
    @ViewBuilder
    func navigationBar(_ title: String, style: NavigationBarStyleType = .system) -> some View {
        switch style {
        case .system:
            NavigationView { self
                .navigationTitle(title)
            }
        case let .fixed(offset):
            #if os(iOS)
                VStack(spacing: .zero) {
                    ModalNavigationBar(title: title, bigTitle: false, offset: offset)
                    self
                }
            #else
                NavigationView { self
                    .navigationTitle(title)
                }
            #endif
        case let .scroll(offset):
            #if os(iOS)
                VStack(spacing: .zero) {
                    ModalNavigationBar(title: title, bigTitle: true, offset: offset, leadingBar: {}, trailingBar: {}, bottomBar: {})
                    self
                }
            #else
                NavigationView { self
                    .navigationTitle(title)
                }
            #endif
        }
    }

    @ViewBuilder
    func navigationBar<LeadingBar: View, TrailingBar: View, BottomBar: View>(
        _ title: String,
        style: NavigationBarStyleType = .system,
        @ViewBuilder leadingBar: @escaping () -> LeadingBar?,
        @ViewBuilder trailingBar: @escaping () -> TrailingBar?,
        @ViewBuilder bottomBar: @escaping () -> BottomBar?
    ) -> some View {
        switch style {
        case .system:
            NavigationView { self
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        leadingBar()
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        trailingBar()
                    }
                }
            }
        case let .fixed(offset):
            #if os(iOS)
                VStack(spacing: .zero) {
                    ModalNavigationBar(title: title, bigTitle: false, offset: offset, leadingBar: leadingBar, trailingBar: trailingBar, bottomBar: bottomBar)
                    self
                }
            #else
                NavigationView { self
                    .navigationTitle(title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            leadingBar()
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            trailingBar()
                        }
                    }
                }
            #endif
        case let .scroll(offset):
            #if os(iOS)
                VStack(spacing: .zero) {
                    ModalNavigationBar(title: title, bigTitle: true, offset: offset, leadingBar: leadingBar, trailingBar: leadingBar, bottomBar: bottomBar)
                    self
                }
            #else
                NavigationView { self
                    .navigationTitle(title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            leadingBar()
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            trailingBar()
                        }
                    }
                }
            #endif
        }
    }

    @ViewBuilder
    func navigationBar<LeadingBar: View, TrailingBar: View>(
        _ title: String,
        style: NavigationBarStyleType = .system,
        @ViewBuilder leadingBar: @escaping () -> LeadingBar?,
        @ViewBuilder trailingBar: @escaping () -> TrailingBar?
    ) -> some View {
        switch style {
        case .system:
            NavigationView { self
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        leadingBar()
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        trailingBar()
                    }
                }
            }
        case let .fixed(offset):
            #if os(iOS)
                VStack(spacing: .zero) {
                    ModalNavigationBar(title: title, bigTitle: false, offset: offset, leadingBar: leadingBar, trailingBar: trailingBar)
                    self
                }
            #else
                NavigationView { self
                    .navigationTitle(title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            leadingBar()
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            trailingBar()
                        }
                    }
                }
            #endif
        case let .scroll(offset):
            #if os(iOS)
                VStack(spacing: .zero) {
                    ModalNavigationBar(title: title, bigTitle: true, offset: offset, leadingBar: leadingBar, trailingBar: trailingBar)
                    self
                }
            #else
                NavigationView { self
                    .navigationTitle(title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            leadingBar()
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            trailingBar()
                        }
                    }
                }
            #endif
        }
    }

    @ViewBuilder
    func navigationBar<LeadingBar: View, TrailingBar: View>(
        _ title: String,
        style: NavigationBarStyleType = .system,
        @ViewBuilder leadingBar: @escaping () -> LeadingBar?
    ) -> some View {
        switch style {
        case .system:
            NavigationView { self
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        leadingBar()
                    }
                }
            }
        case let .fixed(offset):
            #if os(iOS)
                VStack(spacing: .zero) {
                    ModalNavigationBar(title: title, bigTitle: false, offset: offset, leadingBar: leadingBar)
                    self
                }
            #else
                NavigationView { self
                    .navigationTitle(title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            leadingBar()
                        }
                    }
                }
            #endif
        case let .scroll(offset):
            #if os(iOS)
                VStack(spacing: .zero) {
                    ModalNavigationBar(title: title, bigTitle: true, offset: offset, leadingBar: leadingBar)
                    self
                }
            #else
                NavigationView { self
                    .navigationTitle(title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            leadingBar()
                        }
                    }
                }
            #endif
        }
    }

    @ViewBuilder
    func navigationBar<LeadingBar: View, TrailingBar: View>(
        _ title: String,
        style: NavigationBarStyleType = .system,
        @ViewBuilder trailingBar: @escaping () -> TrailingBar?
    ) -> some View {
        switch style {
        case .system:
            NavigationView { self
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        trailingBar()
                    }
                }
            }
        case let .fixed(offset):
            #if os(iOS)
                VStack(spacing: .zero) {
                    ModalNavigationBar(title: title, bigTitle: false, offset: offset, trailingBar: trailingBar)
                    self
                }
            #else
                NavigationView { self
                    .navigationTitle(title)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            trailingBar()
                        }
                    }
                }
            #endif
        case let .scroll(offset):
            #if os(iOS)
                VStack(spacing: .zero) {
                    ModalNavigationBar(title: title, bigTitle: true, offset: offset, trailingBar: trailingBar)
                    self
                }
            #else
                NavigationView { self
                    .navigationTitle(title)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            trailingBar()
                        }
                    }
                }
            #endif
        }
    }

    @ViewBuilder
    func scrollWithNavigationBar<LeadingBar: View, TrailingBar: View, BottomBar: View>(
        _ title: String,
        style: NavigationBarStyleType = .system,
        background: Color = Color.backgroundPrimary,
        @ViewBuilder leadingBar: @escaping () -> LeadingBar?,
        @ViewBuilder trailingBar: @escaping () -> TrailingBar?,
        @ViewBuilder bottomBar: @escaping () -> BottomBar?
    ) -> some View {
        switch style {
        case .system:
            NavigationView {
                ScrollView {
                    self
                }
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        leadingBar()
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        trailingBar()
                    }
                }
            }
        case let .fixed(offset):
            #if os(iOS)
                NavigationView {
                    VStack(spacing: .zero) {
                        ModalNavigationBar(
                            title: title,
                            bigTitle: false,
                            offset: offset,
                            background: background,
                            leadingBar: leadingBar,
                            trailingBar: trailingBar,
                            bottomBar: bottomBar
                        )
                        .zIndex(99_999_999)
                        ScrollViewOffset(offset: offset) {
                            self
                        }
                    }.background(background.ignoresSafeArea())
                }
            #else
                NavigationView {
                    ScrollView {
                        self
                    }
                    .navigationTitle(title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            leadingBar()
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            trailingBar()
                        }
                    }
                }
            #endif
        case let .scroll(offset):
            #if os(iOS)
                VStack(spacing: .zero) {
                    ModalNavigationBar(
                        title: title,
                        bigTitle: true,
                        offset: offset,
                        background: background,
                        leadingBar: leadingBar,
                        trailingBar: trailingBar,
                        bottomBar: bottomBar
                    )
                    ScrollViewOffset(offset: offset) {
                        self
                    }
                }.background(background.ignoresSafeArea())
            #else
                NavigationView {
                    ScrollView {
                        self
                    }
                    .navigationTitle(title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            leadingBar()
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            trailingBar()
                        }
                    }
                }
            #endif
        }
    }
}

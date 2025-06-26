//
// Copyright © 2021 Alexander Romanov
// View+NavigationView.swift, created on 11.09.2021
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
    func navigationBar(_ title: String, style: NavigationBarStyleType) -> some View {
        switch style {
        case .system:
            NavigationView { self
                .navigationTitle(title)
            }
        case let .fixed(offset):
            #if os(iOS)
            VStack(spacing: .zero) {
                ModalNavigationBar(title: title, largeTitle: false, offset: offset)
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
                ModalNavigationBar(title: title, largeTitle: true, offset: offset, leadingBar: {}, trailingBar: {}, bottomBar: {}, titleLabel: {})
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
    func navigationBar(
        _ title: String,
        style: NavigationBarStyleType = .system,
        @ViewBuilder leadingBar: @escaping () -> (some View)?,
        @ViewBuilder trailingBar: @escaping () -> (some View)?,
        @ViewBuilder bottomBar: @escaping () -> (some View)?
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
                ModalNavigationBar(title: title, largeTitle: false, offset: offset, leadingBar: leadingBar, trailingBar: trailingBar, bottomBar: bottomBar, titleLabel: {})
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
                ModalNavigationBar(title: title, largeTitle: true, offset: offset, leadingBar: leadingBar, trailingBar: leadingBar, bottomBar: bottomBar, titleLabel: {})
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
    func navigationBar(
        _ title: String,
        style: NavigationBarStyleType = .system,
        @ViewBuilder leadingBar: @escaping () -> (some View)?,
        @ViewBuilder trailingBar: @escaping () -> (some View)?
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
                ModalNavigationBar(title: title, largeTitle: false, offset: offset, leadingBar: leadingBar, trailingBar: trailingBar)
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
                ModalNavigationBar(title: title, largeTitle: true, offset: offset, leadingBar: leadingBar, trailingBar: trailingBar)
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
    func navigationBar(
        _ title: String,
        style: NavigationBarStyleType = .system,
        @ViewBuilder leadingBar: @escaping () -> (some View)?
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
                ModalNavigationBar(title: title, largeTitle: false, offset: offset, leadingBar: leadingBar)
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
                ModalNavigationBar(title: title, largeTitle: true, offset: offset, leadingBar: leadingBar)
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
    func navigationBar(
        _ title: String,
        style: NavigationBarStyleType = .system,
        @ViewBuilder trailingBar: @escaping () -> (some View)?
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
                ModalNavigationBar(title: title, largeTitle: false, offset: offset, trailingBar: trailingBar)
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
                ModalNavigationBar(title: title, largeTitle: true, offset: offset, trailingBar: trailingBar)
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
    func scrollWithNavigationBar(
        _ title: String,
        style: NavigationBarStyleType = .system,
        background: Color = Color.backgroundPrimary,
        @ViewBuilder leadingBar: @escaping () -> (some View)?,
        @ViewBuilder trailingBar: @escaping () -> (some View)?,
        @ViewBuilder bottomBar: @escaping () -> (some View)?
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
                        largeTitle: false,
                        offset: offset,
                        background: background,
                        leadingBar: leadingBar,
                        trailingBar: trailingBar,
                        bottomBar: bottomBar,
                        titleLabel: {}
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
                    largeTitle: true,
                    offset: offset,
                    background: background,
                    leadingBar: leadingBar,
                    trailingBar: trailingBar,
                    bottomBar: bottomBar,
                    titleLabel: {}
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

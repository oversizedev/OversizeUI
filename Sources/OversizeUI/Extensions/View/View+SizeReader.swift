//
// Copyright © 2021 Alexander Romanov
// View+SizeReader.swift, created on 11.09.2021
//

import SwiftUI

public extension View {
    func readGeometry<Value: Equatable & Sendable>(
        _ transform: @escaping @Sendable (GeometryProxy) -> Value,
        onChange: @escaping (Value) -> Void
    ) -> some View {
        modifier(GeometryChangeModifier(transform: transform, action: onChange))
    }

    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        readGeometry({ $0.size }, onChange: onChange)
    }

    func readSafeAreaInsets(onChange: @escaping (EdgeInsets) -> Void) -> some View {
        readGeometry({ $0.safeAreaInsets }, onChange: onChange)
    }

    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
    func readScrollViewSize(onChange: @escaping (CGSize) -> Void) -> some View {
        onGeometryChange(
            for: CGSize.self,
            of: { $0.bounds(of: .scrollView)?.size ?? $0.size },
            action: onChange
        )
    }
}

private struct GeometryChangeModifier<Value: Equatable & Sendable>: ViewModifier {
    let transform: @Sendable (GeometryProxy) -> Value
    let action: (Value) -> Void

    func body(content: Content) -> some View {
        #if os(iOS) || os(tvOS)
        if #available(iOS 16.0, tvOS 16.0, *) {
            content.onGeometryChange(for: Value.self, of: transform, action: action)
        } else {
            content.background {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear { action(transform(proxy)) }
                        .onChange(of: transform(proxy)) { newValue in
                            action(newValue)
                        }
                }
            }
        }
        #else
        content.onGeometryChange(for: Value.self, of: transform, action: action)
        #endif
    }
}

//
// Copyright © 2022 Alexander Romanov
// HalfSheet.swift
//

import SwiftUI

#if os(iOS)
    import UIKit

    public enum Detents {
        case large
        case medium

        public var uiViewDetents: UISheetPresentationController.Detent {
            switch self {
            case .large:
                return .large()
            case .medium:
                return .medium()
            }
        }
    }
#endif
// swiftlint:disable line_length
#if os(iOS)

    @available(iOS 15, *)
    public struct SheetModifier: ViewModifier {
        public let detents: [Detents]
        public func body(content: Content) -> some View {
            SheetView(detents: detents) {
                content
            }
        }
    }

    public extension View {
        @_disfavoredOverload
        func presentationDetents(_ detents: [Detents]) -> some View {
            modifier(SheetModifier(detents: detents))
        }
    }

    public struct SheetView<Content: View>: UIViewControllerRepresentable {
        private let content: Content
        private let detents: [Detents]

        public init(detents: [Detents], @ViewBuilder content: () -> Content) {
            self.content = content()
            self.detents = detents
        }

        public func makeUIViewController(context _: Context) -> SheetHostingController<Content> {
            SheetHostingController(rootView: content, detents: detents.map { $0.uiViewDetents })
        }

        public func updateUIViewController(_: SheetHostingController<Content>, context _: Context) {}
    }

    public final class SheetHostingController<Content: View>: UIHostingController<Content> {
        var detents: [UISheetPresentationController.Detent] = []

        override public func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let controller = sheetPresentationController {
                controller.detents = detents
            }
        }
    }

    public extension SheetHostingController {
        convenience init(rootView: Content, detents: [UISheetPresentationController.Detent]) {
            self.init(rootView: rootView)
            self.detents = detents
        }
    }
#endif

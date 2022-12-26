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
        case height(CGFloat)

        public var uiViewDetents: UISheetPresentationController.Detent {
            switch self {
            case .large:
                return .large()
            case .medium:
                return .medium()
            case let .height(height):
                return height > 560 ? .large() : .medium()
            }
        }

        @available(iOS 16, *)
        func convertToSUI() -> PresentationDetent {
            switch self {
            case .large:
                return PresentationDetent.large
            case .medium:
                return PresentationDetent.medium
            case let .height(height):
                return PresentationDetent.height(height)
            }
        }
    }
#endif
// swiftlint:disable line_length
#if os(iOS)

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
            Group {
                if #available(iOS 16, *) {
                    let suiDetents: Set<PresentationDetent> = Set(detents.compactMap { $0.convertToSUI() })
                    self.presentationDetents(suiDetents)
                } else {
                    modifier(SheetModifier(detents: detents))
                }
            }
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

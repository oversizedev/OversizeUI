//
// Copyright © 2022 Alexander Romanov
// HalfSheet.swift, created on 30.12.2022
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

public enum Detents: Hashable {
    case large
    case medium
    case height(CGFloat)

    #if os(iOS)
    @available(iOS 15, *)
    public var uiViewDetents: UISheetPresentationController.Detent {
        switch self {
        case .large:
            .large()
        case .medium:
            .medium()
        case let .height(height):
            height > 560 ? .large() : .medium()
        }
    }

    @available(iOS 16, *)
    func convertToSUI() -> PresentationDetent {
        switch self {
        case .large:
            PresentationDetent.large
        case .medium:
            PresentationDetent.medium
        case let .height(height):
            PresentationDetent.height(height)
        }
    }
    #endif
}

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
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
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

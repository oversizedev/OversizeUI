//
// Copyright © 2022 Alexander Romanov
// HalfSheet.swift
//

import SwiftUI

public enum SheetSize {
    case medium, large
}

public extension View {
    @_disfavoredOverload
    @ViewBuilder func sheet<T: View>(isPresented: Binding<Bool>,
                                     detents: [SheetSize] = [.medium, .large],
                                     smallestUndimmedDetentIdentifier: SheetSize = .medium,
                                     prefersScrollingExpandsWhenScrolledToEdge: Bool = false,
                                     prefersEdgeAttachedInCompactHeight: Bool = true,
                                     @ViewBuilder content: @escaping () -> T) -> some View
    {
        if #available(iOS 15, *) {
            modifier(HalfSheet(isPresented: isPresented,
                               detents: detents,
                               smallestUndimmedDetentIdentifier: smallestUndimmedDetentIdentifier,
                               prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge,
                               prefersEdgeAttachedInCompactHeight: prefersEdgeAttachedInCompactHeight,
                               content: content))
        } else {
            sheet(isPresented: isPresented, content: content)
        }
    }
}

// swiftlint:disable line_length
@available(iOS 15.0, *)
public struct HalfSheet<T: View>: ViewModifier {
    let sheetContent: T
    @Binding var isPresented: Bool
    let detents: [UISheetPresentationController.Detent]
    let smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    let prefersScrollingExpandsWhenScrolledToEdge: Bool
    let prefersEdgeAttachedInCompactHeight: Bool

    public init(isPresented: Binding<Bool>, detents: [SheetSize] = [.medium, .large], smallestUndimmedDetentIdentifier: SheetSize = .medium, prefersScrollingExpandsWhenScrolledToEdge: Bool = false, prefersEdgeAttachedInCompactHeight: Bool = true, @ViewBuilder content: @escaping () -> T) {
        sheetContent = content()
        var detentsTemp: [UISheetPresentationController.Detent] = []
        for detent in detents {
            if detent == .medium {
                detentsTemp.append(.medium())
            }
            if detent == .large {
                detentsTemp.append(.large())
            }
        }
        self.detents = detentsTemp
        switch smallestUndimmedDetentIdentifier {
        case .medium:
            self.smallestUndimmedDetentIdentifier = .medium
        case .large:
            self.smallestUndimmedDetentIdentifier = .large
        }
        self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        _isPresented = isPresented
    }

    public func body(content: Content) -> some View {
        ZStack {
            content
            HalfSheetUI(isPresented: $isPresented, detents: detents, smallestUndimmedDetentIdentifier: smallestUndimmedDetentIdentifier, prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge, prefersEdgeAttachedInCompactHeight: prefersEdgeAttachedInCompactHeight, content: { sheetContent }).frame(width: 0, height: 0)
        }
    }
}

// swiftlint:disable type_name superfluous_disable_command
@available(iOS 15.0, *)
public struct HalfSheetUI<Content: View>: UIViewControllerRepresentable {
    let content: Content
    @Binding var isPresented: Bool
    let detents: [UISheetPresentationController.Detent]
    let smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    let prefersScrollingExpandsWhenScrolledToEdge: Bool
    let prefersEdgeAttachedInCompactHeight: Bool

    public init(isPresented: Binding<Bool>, detents: [UISheetPresentationController.Detent] = [.medium(), .large()], smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = .medium, prefersScrollingExpandsWhenScrolledToEdge: Bool = false, prefersEdgeAttachedInCompactHeight: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.detents = detents
        self.smallestUndimmedDetentIdentifier = smallestUndimmedDetentIdentifier
        self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        _isPresented = isPresented
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeUIViewController(context: Context) -> HalfSheetViewController<Content> {
        let vc = HalfSheetViewController(coordinator: context.coordinator, detents: detents, smallestUndimmedDetentIdentifier: smallestUndimmedDetentIdentifier, prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge, prefersEdgeAttachedInCompactHeight: prefersEdgeAttachedInCompactHeight, content: { content })
        return vc
    }

    public func updateUIViewController(_ uiViewController: HalfSheetViewController<Content>, context _: Context) {
        if isPresented {
            uiViewController.presentModalView()
        } else {
            uiViewController.dismissModalView()
        }
    }

    public class Coordinator: NSObject, UIAdaptivePresentationControllerDelegate {
        var parent: HalfSheetUI
        init(_ parent: HalfSheetUI) {
            self.parent = parent
        }

        public func presentationControllerDidDismiss(_: UIPresentationController) {
            if parent.isPresented {
                parent.isPresented = false
            }
        }
    }
}

@available(iOS 15.0, *)
public class HalfSheetViewController<Content: View>: UIViewController {
    let content: Content
    let coordinator: HalfSheetUI<Content>.Coordinator
    let detents: [UISheetPresentationController.Detent]
    let smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    let prefersScrollingExpandsWhenScrolledToEdge: Bool
    let prefersEdgeAttachedInCompactHeight: Bool
    private var isLandscape: Bool = UIDevice.current.orientation.isLandscape
    public init(coordinator: HalfSheetUI<Content>.Coordinator, detents: [UISheetPresentationController.Detent] = [.medium(), .large()], smallestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = .medium, prefersScrollingExpandsWhenScrolledToEdge: Bool = false, prefersEdgeAttachedInCompactHeight: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.coordinator = coordinator
        self.detents = detents
        self.smallestUndimmedDetentIdentifier = smallestUndimmedDetentIdentifier
        self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        super.init(nibName: nil, bundle: .main)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func dismissModalView() {
        dismiss(animated: true, completion: nil)
    }

    func presentModalView() {
        let hostingController = UIHostingController(rootView: content)

        hostingController.modalPresentationStyle = .popover
        hostingController.presentationController?.delegate = coordinator as UIAdaptivePresentationControllerDelegate
        hostingController.modalTransitionStyle = .coverVertical
        if let hostPopover = hostingController.popoverPresentationController {
            hostPopover.sourceView = super.view
            let sheet = hostPopover.adaptiveSheetPresentationController
            sheet.detents = (isLandscape ? [.large()] : detents)
            sheet.largestUndimmedDetentIdentifier =
                smallestUndimmedDetentIdentifier
            sheet.prefersScrollingExpandsWhenScrolledToEdge =
                prefersScrollingExpandsWhenScrolledToEdge
            sheet.prefersEdgeAttachedInCompactHeight =
                prefersEdgeAttachedInCompactHeight
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        if presentedViewController == nil {
            present(hostingController, animated: true, completion: nil)
        }
    }

    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            isLandscape = true
            presentedViewController?.popoverPresentationController?.adaptiveSheetPresentationController.detents = [.large()]
        } else {
            isLandscape = false
            presentedViewController?.popoverPresentationController?.adaptiveSheetPresentationController.detents = detents
        }
    }
}

struct HalfSheetView_Previews: PreviewProvider {
    struct HalfSheetDemo: View {
        @State private var isPresented = false
        var body: some View {
            VStack {
                Button("Present sheet", action: {
                    isPresented.toggle()
                }).sheet(isPresented: $isPresented,
                         detents: [.medium, .large],
                         smallestUndimmedDetentIdentifier: .large)
                {
                    Text("Sheet content")
                }
            }
        }
    }

    static var previews: some View {
        HalfSheetDemo()
    }
}

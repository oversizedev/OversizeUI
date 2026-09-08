//
// Copyright © 2026 Alexander Romanov
// ListScrollOffsetReader.swift, created on 06.05.2026
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(visionOS)
@available(iOS 17.0, tvOS 17.0, visionOS 1.0, *)
struct ListScrollOffsetReader: UIViewRepresentable {
    let onScroll: @MainActor (CGFloat) -> Void

    func makeUIView(context _: Context) -> ListScrollOffsetUIView {
        let view = ListScrollOffsetUIView()
        view.onScroll = onScroll
        return view
    }

    func updateUIView(_ uiView: ListScrollOffsetUIView, context _: Context) {
        uiView.onScroll = onScroll
    }
}

@available(iOS 17.0, tvOS 17.0, visionOS 1.0, *)
final class ListScrollOffsetUIView: UIView {
    var onScroll: (@MainActor (CGFloat) -> Void)?
    private var observation: NSKeyValueObservation?

    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard window != nil, observation == nil else { return }
        DispatchQueue.main.async { [weak self] in
            self?.observeScrollView()
        }
    }

    private func observeScrollView() {
        var current: UIView? = self
        while let view = current {
            if let scrollView = view as? UIScrollView {
                observation = scrollView.observe(\.contentOffset, options: .new) { [weak self] _, _ in
                    MainActor.assumeIsolated {
                        guard let self else { return }
                        let offset = scrollView.contentOffset.y + scrollView.adjustedContentInset.top
                        self.onScroll?(offset)
                    }
                }
                return
            }
            current = view.superview
        }
    }
}
#endif

#if os(macOS)
@available(macOS 14.0, *)
struct ListScrollOffsetReader: NSViewRepresentable {
    let onScroll: @MainActor (CGFloat) -> Void

    func makeNSView(context _: Context) -> ListScrollOffsetNSView {
        let view = ListScrollOffsetNSView()
        view.onScroll = onScroll
        return view
    }

    func updateNSView(_ nsView: ListScrollOffsetNSView, context _: Context) {
        nsView.onScroll = onScroll
    }
}

@available(macOS 14.0, *)
final class ListScrollOffsetNSView: NSView {
    var onScroll: (@MainActor (CGFloat) -> Void)?
    private nonisolated(unsafe) var observer: NSObjectProtocol?
    private weak var observedScrollView: NSScrollView?

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        guard window != nil, observer == nil else { return }
        DispatchQueue.main.async { [weak self] in
            self?.observeScrollView()
        }
    }

    deinit {
        if let observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    private func observeScrollView() {
        var current: NSView? = self
        while let view = current {
            if let scrollView = view as? NSScrollView {
                observe(scrollView)
                return
            }
            current = view.superview
        }
    }

    private func observe(_ scrollView: NSScrollView) {
        observedScrollView = scrollView
        let clipView = scrollView.contentView
        clipView.postsBoundsChangedNotifications = true
        observer = NotificationCenter.default.addObserver(
            forName: NSView.boundsDidChangeNotification,
            object: clipView,
            queue: .main
        ) { [weak self] _ in
            MainActor.assumeIsolated {
                guard let self, let scrollView = self.observedScrollView else { return }
                let offset = scrollView.contentView.bounds.origin.y + scrollView.contentInsets.top
                self.onScroll?(offset)
            }
        }
    }
}
#endif

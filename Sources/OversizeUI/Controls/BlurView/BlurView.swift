//
// Copyright © 2022 Alexander Romanov
// BlurView.swift
//

import Foundation
import SwiftUI

// swiftlint:disable all
#if os(iOS)
    public struct BlurView: UIViewRepresentable {
        public init(_ style: UIBlurEffect.Style = .light) {
            self.style = style
        }

        public let style: UIBlurEffect.Style

        public func makeUIView(context _: UIViewRepresentableContext<BlurView>) -> UIView {
            let view: UIView = .init(frame: .zero)
            view.backgroundColor = .clear
            let blurEffect: UIBlurEffect = .init(style: style)
            let blurView: UIVisualEffectView = .init(effect: blurEffect)
            blurView.translatesAutoresizingMaskIntoConstraints = false
            view.insertSubview(blurView, at: 0)
            NSLayoutConstraint.activate([
                blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
                blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            ])
            return view
        }

        public func updateUIView(_: UIView,
                                 context _: UIViewRepresentableContext<BlurView>) {}
    }
#endif

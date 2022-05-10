//
// Copyright © 2022 Alexander Romanov
// ActivityViewController.swift
//

#if os(iOS)
    import SwiftUI
    import UIKit

    public struct ActivityViewController: UIViewControllerRepresentable {
        public init(activityItems: [Any], applicationActivities: [UIActivity]? = nil) {
            self.activityItems = activityItems
            self.applicationActivities = applicationActivities
        }

        var activityItems: [Any]
        var applicationActivities: [UIActivity]?

        public func makeUIViewController(context _: UIViewControllerRepresentableContext<ActivityViewController>)
            -> UIActivityViewController
        {
            let controller = UIActivityViewController(activityItems: activityItems,
                                                      applicationActivities: applicationActivities)
            return controller
        }

        public func updateUIViewController(_: UIActivityViewController,
                                           context _: UIViewControllerRepresentableContext<ActivityViewController>) {}
    }
#endif

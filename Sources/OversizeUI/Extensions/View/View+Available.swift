//
// Copyright © 2021 Alexander Romanov
// View+Available.swift, created on 23.12.2022
//

import SwiftUI

public enum PresentationContentInteraction {
    case automatic, resizes, scrolls
}

public enum PresentationAdaptation {
    case automatic, none, popover, sheet, fullScreenCover
}

public extension View {
    @available(tvOS, unavailable)
    @_disfavoredOverload
    @ViewBuilder
    func scrollContentBackground(_ visibility: Visibility) -> some View {
        if #available(iOS 16, macOS 13.0, watchOS 9.0, *) {
            self.scrollContentBackground(visibility)
        } else {
            self
        }
    }

    @_disfavoredOverload
    @ViewBuilder
    func presentationDragIndicator(_ visibility: Visibility) -> some View {
        if #available(iOS 16, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            self.presentationDragIndicator(visibility)
        } else {
            self
        }
    }

    @_disfavoredOverload
    @ViewBuilder
    func presentationContentInteraction(_ behavior: PresentationContentInteraction) -> some View {
        if #available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *) {
            self.presentationContentInteraction(behavior == .automatic ? .automatic : behavior == .resizes ? .resizes : .scrolls)
        } else {
            self
        }
    }

    @_disfavoredOverload
    @ViewBuilder
    func presentationCompactAdaptation(_ adaptation: PresentationAdaptation) -> some View {
        if #available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *) {
            self.presentationCompactAdaptation(
                adaptation == .automatic ? .automatic : adaptation == .none ? .none : adaptation == .popover ? .popover : adaptation == .sheet ? .sheet : .fullScreenCover)
        } else {
            self
        }
    }

    @_disfavoredOverload
    @ViewBuilder
    func scrollDisabled(_ disabled: Bool) -> some View {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            self.scrollDisabled(disabled)
        } else {
            self
        }
    }
}

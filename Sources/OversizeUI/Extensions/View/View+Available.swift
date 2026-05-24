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
            scrollContentBackground(visibility)
        } else {
            self
        }
    }

    @_disfavoredOverload
    @ViewBuilder
    func presentationDragIndicator(_ visibility: Visibility) -> some View {
        if #available(iOS 16, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            presentationDragIndicator(visibility)
        } else {
            self
        }
    }

    @_disfavoredOverload
    @ViewBuilder
    func presentationContentInteraction(_ behavior: PresentationContentInteraction) -> some View {
        if #available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *) {
            presentationContentInteraction(behavior == .automatic ? .automatic : behavior == .resizes ? .resizes : .scrolls)
        } else {
            self
        }
    }

    @_disfavoredOverload
    @ViewBuilder
    func presentationCompactAdaptation(_ adaptation: PresentationAdaptation) -> some View {
        if #available(iOS 16.4, macOS 13.3, tvOS 16.4, watchOS 9.4, *) {
            presentationCompactAdaptation(
                adaptation == .automatic ? .automatic : adaptation == .none ? .none : adaptation == .popover ? .popover : adaptation == .sheet ? .sheet : .fullScreenCover
            )
        } else {
            self
        }
    }

    @_disfavoredOverload
    @ViewBuilder
    func scrollDisabled(_ disabled: Bool) -> some View {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            scrollDisabled(disabled)
        } else {
            self
        }
    }

    @available(visionOS, unavailable)
    @_disfavoredOverload
    @ViewBuilder
    func scrollEdgeEffectHidden(_ hidden: Bool = true, for edges: Edge.Set = .all) -> some View {
        if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
            scrollEdgeEffectHidden(hidden, for: edges)
        } else {
            self
        }
    }

    @ViewBuilder
    func safeAreaBarTop(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: @escaping () -> some View) -> some View {
        if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
            safeAreaBar(edge: .top, alignment: alignment, spacing: spacing, content: content)
        } else {
            safeAreaInset(edge: .top, alignment: alignment, spacing: spacing, content: content)
        }
    }

    @ViewBuilder
    func safeAreaBarBottom(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: @escaping () -> some View) -> some View {
        if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
            safeAreaBar(edge: .bottom, alignment: alignment, spacing: spacing, content: content)
        } else {
            safeAreaInset(edge: .bottom, alignment: alignment, spacing: spacing, content: content)
        }
    }

    @_disfavoredOverload
    @ViewBuilder
    func listSectionIndexVisibility(_ visibility: Visibility) -> some View {
        if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
            listSectionIndexVisibility(visibility)
        } else {
            self
        }
    }

    @_disfavoredOverload
    @ViewBuilder
    func matchedTransitionSource(id: some Hashable, in namespace: Namespace.ID) -> some View {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
            matchedTransitionSource(id: id, in: namespace)
        } else {
            self
        }
    }

    @ViewBuilder
    func navigationTransitionZoom(sourceID: some Hashable, in namespace: Namespace.ID) -> some View {
        #if !os(macOS)
        if #available(iOS 18.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
            navigationTransition(.zoom(sourceID: sourceID, in: namespace))
        } else {
            self
        }
        #else
        self
        #endif
    }
}

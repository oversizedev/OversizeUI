////
//// Copyright © 2025 Alexander Romanov
//// ScrollViewOffsetTracker.swift, created on 11.05.2025
////
//
//
////
////  ScrollViewOffsetTracker.swift
////  ScrollKit
////
////  Created by Daniel Saidi on 2023-12-04.
////  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
////
//
// import SwiftUI
//
///// This view can wrap any `ScrollView` or `List` content to
///// get offset tracking working when the view is scrolled.
/////
///// To use this view, add it within a `ScrollView` or `List`,
///// then apply ``SwiftUI/View/scrollViewOffsetTracking(action:)``
///// to the parent view, like this:
/////
///// ```swift
///// List {
/////     ScrollViewOffsetTracker {
/////         ForEach(0...100, id: \.self) {
/////             Text("\($0)")
/////                 .frame(width: 200, height: 200)
/////         }
/////     }
///// }
///// .scrollViewOffsetTracking { offset in
/////     print(offset)
///// }
///// ```
/////
///// The offset action will trigger when the list scrolls and
///// provide you with the scroll offset.
// public struct ScrollViewOffsetTracker<Content: View>: View {
//
//    public init(
//        @ViewBuilder content: @escaping () -> Content
//    ) {
//        self.content = content
//    }
//
//    private var content: () -> Content
//
//    public var body: some View {
//        ZStack(alignment: .top) {
//            GeometryReader { geo in
//                Color.clear
//                    .preference(
//                        key: ScrollOffsetPreferenceKey.self,
//                        value: geo.frame(in: .named(ScrollOffsetNamespace.namespace)).origin
//                    )
//            }
//            .frame(height: 0)
//
//            content()
//        }
//    }
// }
//
// public extension View {
//
//    /// Add this modifier to a `ScrollView`, a `List` or any
//    /// view that has a ``ScrollViewOffsetTracker`` to track
//    /// its scroll offset.
//    func scrollViewOffsetTracking(
//        action: @escaping @MainActor @Sendable (_ offset: CGPoint) -> Void
//    ) -> some View {
//        self.coordinateSpace(name: ScrollOffsetNamespace.namespace)
//            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
//                DispatchQueue.main.async {
//                    action(offset)
//                }
//            }
//    }
// }
//
//
// enum ScrollOffsetNamespace {
//
//    static let namespace = "scrollView"
// }
//
////struct ScrollOffsetPreferenceKey: PreferenceKey {
////
////    static var defaultValue: CGPoint { .zero }
////
////    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
////}
//
// #Preview {
//
//    struct Preview: View {
//
//        @State
//        private var offset = CGPoint.zero
//
//        var body: some View {
//            ScrollView(.vertical) {
//                ScrollViewOffsetTracker {
//                    VStack {
//                        ForEach(0...100, id: \.self) {
//                            Text("\($0)")
//                                .frame(width: 200, height: 200)
//                                .background(Color.red)
//                        }
//                    }
//                }
//            }
//            .scrollViewOffsetTracking { offset in
//                let roundedX = offset.x.rounded()
//                let roundedY = offset.y.rounded()
//                self.offset = .init(x: roundedX, y: roundedY)
//            }
//            .navigationTitle("\(offset.debugDescription)")
//        }
//    }
//
//    return NavigationView {
//        #if os(macOS)
//        Color.clear
//        #endif
//        Preview()
//    }
// }
//
// public struct ScrollViewWithOffsetTracking<Content: View>: View {
//
//    /// Create a scroll view with offset tracking.
//    ///
//    /// - Parameters:
//    ///   - axes: The scroll axes to use, by default `.vertical`.
//    ///   - showsIndicators: Whether or not to show scroll indicators, by default `true`.
//    ///   - onScroll: An action that will be called whenever the scroll offset changes, by default `nil`.
//    ///   - content: The scroll view content.
//    public init(
//        _ axes: Axis.Set = .vertical,
//        showsIndicators: Bool = true,
//        onScroll: ScrollAction? = nil,
//        @ViewBuilder content: @escaping () -> Content
//    ) {
//        self.axes = axes
//        self.showsIndicators = showsIndicators
//        self.onScroll = onScroll ?? { _ in }
//        self.content = content
//    }
//
//    private let axes: Axis.Set
//    private let showsIndicators: Bool
//    private let onScroll: ScrollAction
//    private let content: () -> Content
//
//    public typealias ScrollAction = @MainActor @Sendable (_ offset: CGPoint) -> Void
//
//    public var body: some View {
//        ScrollView(axes, showsIndicators: showsIndicators) {
//            ScrollViewOffsetTracker {
//                content()
//            }
//        }
//        .scrollViewOffsetTracking(action: onScroll)
//    }
// }

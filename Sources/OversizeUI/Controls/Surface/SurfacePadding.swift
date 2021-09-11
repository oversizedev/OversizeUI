//
// Copyright © 2021 Alexander Romanov
// Created on 26.08.2021
//

// import SwiftUI
//
// public struct SurfacePaddingModifier: ViewModifier {
//
//    private struct Constants {
//
//        /// Size
//        static var paddingMedium: CGFloat { return Space.medium }
//        static var paddingSmall: CGFloat { return Space.small }
//        static var paddingXXXSmall: CGFloat { return Space.xxxSmall }
//        static var paddingXXSmall: CGFloat { return Space.xxSmall }
//        static var paddingZero: CGFloat { return .zero }
//    }
//
//    public var padding: SurfacePadding = .xxxSmall
//
//    public func body(content: Content) -> some View {
//        content
//            .padding(.all,
//                     padding == .xxxSmall ? Constants.paddingXXXSmall
//                        : padding == .xxSmall ? Constants.paddingXXSmall
//                        : padding == .small ? Constants.paddingSmall
//                        : padding == .medium ? Constants.paddingMedium
//                        : Constants.paddingZero
//            )
//
//    }
// }
//
// public extension Surface {
//    func paddingContent(_ padding: SurfacePadding) -> some View {
//        modifier(SurfacePaddingModifier(padding: padding))
//    }
// }

//
// Copyright © 2022 Alexander Romanov
// ScrollViewOffset.swift
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = [CGFloat]

    static var defaultValue: [CGFloat] = [0]

    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}

public struct ScrollViewOffset<Content: View>: View {
    public var contnt: Content

    @Binding public var offset: CGPoint
    public var showIndicators: Bool
    public var axis: Axis.Set
    @State private var startOffset: CGPoint = .zero
    private let coordinateSpace: CoordinateSpace

    public init(offset: Binding<CGPoint>,
                showIndicators: Bool = false,
                axis: Axis.Set = .vertical,
                coordinateSpace: CoordinateSpace = .global,
                @ViewBuilder content: () -> Content)
    {
        contnt = content()
        _offset = offset
        self.showIndicators = showIndicators
        self.axis = axis
        self.coordinateSpace = coordinateSpace
    }

    public var body: some View {
        #if os(iOS)
            iOS
//            GeometryReader { outsideProxy in
//                ScrollView(self.axis, showsIndicators: self.showIndicators) {
//                    ZStack(alignment: self.axis == .vertical ? .top : .leading) {
//                        GeometryReader { insideProxy in
//                            Color.clear
//                                .preference(key: ScrollOffsetPreferenceKey.self,
//                                            value: [self.calculateContentOffset(fromOutsideProxy: outsideProxy, insideProxy: insideProxy)])
//                        }
//                        VStack {
//                            self.contnt
//                        }
//                    }
//                }
//                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
//                    self.offset.y = value[0]
//                }
//            }

        #else
            other
        #endif
    }

//    private func calculateContentOffset(fromOutsideProxy outsideProxy: GeometryProxy,
//                                        insideProxy: GeometryProxy) -> CGFloat
//    {
//        if axis == .vertical {
//            return outsideProxy.frame(in: coordinateSpace).minY - insideProxy.frame(in: coordinateSpace).minY
//        } else {
//            return outsideProxy.frame(in: coordinateSpace).minX - insideProxy.frame(in: coordinateSpace).minX
//        }
//    }

    #if os(iOS)
        private var iOS: some View {
            ScrollView(axis, showsIndicators: showIndicators, content: {
                contnt
                    .overlay(
                        GeometryReader { proxy -> Color in

                            let rect = proxy.frame(in: coordinateSpace)

                            if startOffset == .zero {
                                DispatchQueue.main.async {
                                    startOffset = CGPoint(x: rect.minX, y: rect.minY)
                                }
                            }

                            DispatchQueue.main.async {
                                self.offset = CGPoint(x: startOffset.x - rect.minX, y: startOffset.y - rect.minY)
                            }

                            return Color.clear
                        }

                        .frame(width: UIScreen.main.bounds.width, height: 0),

                        alignment: .top
                    )
            })
        }

        // private var iOS: some View {

    #endif

    private var other: some View {
        ScrollView(axis, showsIndicators: showIndicators, content: {
            contnt
        })
    }
}

//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public struct ScrollViewOffset<Content: View>: View {
    public var contnt: Content

    @Binding public var offset: CGPoint
    public var showIndicators: Bool
    public var axis: Axis.Set
    @State private var startOffset: CGPoint = .zero

    public init(offset: Binding<CGPoint>,
                showIndicators: Bool = false,
                axis: Axis.Set = .vertical,
                @ViewBuilder content: () -> Content)
    {
        contnt = content()
        _offset = offset
        self.showIndicators = showIndicators
        self.axis = axis
    }

    public var body: some View {
        #if os(iOS)
            iOS
        #else
            other
        #endif
    }

    #if os(iOS)
        private var iOS: some View {
            ScrollView(axis, showsIndicators: showIndicators, content: {
                contnt
                    .overlay(
                        GeometryReader { proxy -> Color in

                            let rect = proxy.frame(in: .global)

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
    #endif

    private var other: some View {
        ScrollView(axis, showsIndicators: showIndicators, content: {
            contnt
        })
    }
}

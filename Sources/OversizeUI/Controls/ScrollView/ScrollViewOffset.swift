//
// Copyright © 2021 Alexander Romanov
// ScrollViewOffset.swift, created on 06.04.2021
//

import SwiftUI

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
        ScrollView(axis, showsIndicators: showIndicators, content: {
            contnt
                .overlay(alignment: .top) {
                    #if os(iOS)
                        GeometryReader { proxy -> Color in
                            let rect = proxy.frame(in: coordinateSpace)
                            if startOffset == .zero {
                                DispatchQueue.main.async {
                                    startOffset = CGPoint(x: rect.minX, y: rect.minY)
                                }
                            }
                            DispatchQueue.main.async {
                                offset = CGPoint(x: startOffset.x - rect.minX, y: startOffset.y - rect.minY)
                            }
                            return Color.clear
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 0)
                    #endif
                }
        })
    }
}

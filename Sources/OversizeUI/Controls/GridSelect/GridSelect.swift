//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public struct GridSelect<Element: Equatable, Content, Selection>: View
    where
    Content: View,
    Selection: View
{
    @ObservedObject var appearanceSettings = AppearanceSettings.shared

    @Environment(\.gridSelectStyle) private var style
    public typealias Data = [Element]

    @State private var frames: [CGRect]
    @State private var selectedIndex: Data.Index?
    @Binding private var selection: Data.Element

    private let radius: Radius
    private let data: Data
    private let selectionView: () -> Selection?
    private let content: (Data.Element, Bool) -> Content
    private let grid = [GridItem(),
                        GridItem()]

    public init(_ data: Data,
                selection: Binding<Data.Element>,
                radius: Radius = .medium,
                @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
                @ViewBuilder selectionView: @escaping () -> Selection? = { nil })
    {
        self.data = data
        self.content = content
        self.selectionView = selectionView
        self.radius = radius
        _selection = selection
        _frames = State(wrappedValue: Array(repeating: .zero,
                                            count: data.count))
    }

    public var body: some View {
        style
            .makeBody(
                configuration: GridSelectConfiguration(
                    label: GridSelectConfiguration.Label(content: gridSelect)
                )
            )
    }

    private var gridSelect: some View {
        LazyVGrid(columns: grid) {
            ForEach(data.indices, id: \.self) { index in

                Button(action: {
                    selectedIndex = index
                    selection = data[index]
                }, label: {
                    HStack {
                        Spacer()
                        content(data[index], selectedIndex == index)
                            .animation(.easeInOut(duration: 0.3))
                            .background(selectedIndex == index
                                ? itemBackground
                                .frame(width: frames[selectedIndex ?? 0].width,
                                       height: frames[selectedIndex ?? 0].height)
                                : nil)
                        Spacer()
                    }
                    .background(getUnselection(unselectionStyle: style.unseletionStyle))

                })
                    .buttonStyle(PlainButtonStyle())
                    .background(GeometryReader { proxy in
                        Color.clear.onAppear { frames[index] = proxy.frame(in: .global) }
                    })
            }
        }.onAppear {
            let selctedValue = self.selection
            var index = 0
            for dataValue in data {
                if selctedValue == dataValue {
                    selectedIndex = index
                }
                index += 1
            }
        }
    }

    private var itemBackground: some View {
        ZStack {
            selectionView()
            getSelection(selectionStyle: style.seletionStyle)
        }
    }

    @ViewBuilder
    private func getSelection(selectionStyle: GridSelectSeletionStyle) -> some View {
        switch selectionStyle {
        case .shadowSurface:

            RoundedRectangle(cornerRadius: radius.rawValue,
                             style: .continuous)
                .fill(Color.surfacePrimary)
                .overlay(
                    RoundedRectangle(cornerRadius: radius.rawValue,
                                     style: .continuous)
                        .stroke(appearanceSettings.borderControls
                            ? Color.border
                            : Color.surfaceSecondary, lineWidth: CGFloat(appearanceSettings.borderSize))
                )
                .shadowElevaton(.z2)
        case .graySurface:

            RoundedRectangle(cornerRadius: radius.rawValue,
                             style: .continuous)
                .strokeBorder(Color.onSurfaceMediumEmphasis, lineWidth: 2)
        case .accentSurface:
            RoundedRectangle(cornerRadius: radius.rawValue,
                             style: .continuous)
                .strokeBorder(Color.blue, lineWidth: 2)
        }
    }

    @ViewBuilder
    private func getUnselection(unselectionStyle: GridSelectUnseletionStyle) -> some View {
        switch unselectionStyle {
        case .clean:
            EmptyView()
        case .surface:

            RoundedRectangle(cornerRadius: radius.rawValue,
                             style: .continuous)
                .fill(Color.surfaceSecondary)
                .overlay(
                    RoundedRectangle(cornerRadius: radius.rawValue,
                                     style: .continuous)
                        .stroke(appearanceSettings.borderControls
                            ? Color.border
                            : Color.surfaceSecondary, lineWidth: CGFloat(appearanceSettings.borderSize))
                )
        }
    }
}

public extension GridSelect where Selection == EmptyView {
    init(_ data: Data,
         selection: Binding<Data.Element>,
         radius: Radius = .medium,
         @ViewBuilder content: @escaping (Data.Element, Bool) -> Content)
    {
        self.data = data
        self.content = content
        self.radius = radius
        selectionView = { nil }
        _selection = selection
        _frames = State(wrappedValue: Array(repeating: .zero,
                                            count: data.count))
    }
}

// swiftlint:disable all
struct GridSelect_Preview: PreviewProvider {
    struct GridSelectPreview: View {
        var items = ["One", "Two", "Three", "Four"]

        @State var selection = ""

        var body: some View {
            Group {
                GridSelect(items, selection: $selection,
                           content: { item, _ in
                               VStack {
                                   Icon(.circle)
                                   Text(item)
                               }.padding()
                           })
                    .previewDisplayName("Default")

                GridSelect(items, selection: $selection,
                           content: { item, _ in
                               VStack {
                                   Icon(.circle)
                                   Text(item)
                               }.padding()
                           })
                    .previewDisplayName("Selection Only")
                    .gridSelectStyle(SelectionOnlyGridSelectStyle())
            }
            .previewLayout(.sizeThatFits)
            .padding()
        }
    }

    static var previews: some View {
        GridSelectPreview()
    }
}

//
// Copyright © 2021 Alexander Romanov
// GridSelect.swift, created on 11.09.2021
//

import SwiftUI

public struct GridSelect<Element: Equatable, Content, Selection>: View
    where
    Content: View,
    Selection: View
{
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.gridSelectStyle) private var style

    public typealias Data = [Element]

    @State private var frames: [CGRect]
    @State private var selectedIndex: Data.Index?
    @Binding private var selection: Data.Element

    private let radius: Radius
    private let data: Data
    private let spacing: Space
    private let selectionView: () -> Selection?
    private let content: (Data.Element, Bool) -> Content
    private let action: (() -> Void)?

    public init(
        _ data: Data,
        selection: Binding<Data.Element>,
        radius: Radius = .medium,
        spacing: Space = .xSmall,
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        @ViewBuilder selectionView: @escaping () -> Selection? = { nil },
        action: (() -> Void)? = nil
    ) {
        self.data = data
        self.content = content
        self.selectionView = selectionView
        self.radius = radius
        self.spacing = spacing
        self.action = action
        _selection = selection
        _frames = State(wrappedValue: Array(
            repeating: .zero,
            count: data.count
        ))
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
        LazyVGrid(
            columns: [GridItem(spacing: spacing), GridItem(spacing: spacing)],
            spacing: spacing
        ) {
            ForEach(data.indices, id: \.self) { index in
                Button(action: {
                    selectedIndex = index
                    selection = data[index]
                    action?()
                }, label: {
                    HStack(spacing: .zero) {
                        content(data[index], selectedIndex == index)
                            // .animation(.easeInOut(duration: 0.3))
                            .overlay(selectedIndex == index
                                ? itemBackground
                                .frame(
                                    width: frames[selectedIndex ?? 0].width,
                                    height: frames[selectedIndex ?? 0].height
                                )
                                : nil)
                    }
                    .background(getUnselection(unselectionStyle: style.unseletionStyle))

                })
                .background(GeometryReader { proxy in
                    Color.clear.onAppear { frames[index] = proxy.frame(in: .global) }
                })
                .buttonStyle(PlainButtonStyle())
            }
        }.onAppear {
            let selctedValue = selection
            var index = 0
            for dataValue in data {
                if selctedValue == dataValue {
                    selectedIndex = index
                }
                index += 1
            }
        }
        .animation(.easeInOut(duration: 0.3), value: selection)
    }

    private var itemBackground: some View {
        ZStack {
            getSelection(selectionStyle: style.seletionStyle)
            getSelectionIconDeprecated(icon: style.icon)
            selectionView()
        }
    }

    @ViewBuilder
    private func getSelection(selectionStyle: GridSelectSeletionStyle) -> some View {
        switch selectionStyle {
        case .shadowSurface:
            RoundedRectangle(
                cornerRadius: radius,
                style: .continuous
            )
            .fill(Color.surfacePrimary)
            .overlay(
                RoundedRectangle(
                    cornerRadius: radius,
                    style: .continuous
                )
                .stroke(
                    theme.borderControls
                        ? Color.border
                        : Color.surfaceSecondary,
                    lineWidth: CGFloat(theme.borderSize)
                )
            )
            .shadowElevation(.z2)
        case .graySurface:
            RoundedRectangle(
                cornerRadius: radius,
                style: .continuous
            )
            .strokeBorder(Color.onSurfaceSecondary, lineWidth: 2)
        case .accentSurface:
            RoundedRectangle(
                cornerRadius: radius.rawValue,
                style: .continuous
            )
            .strokeBorder(Color.blue, lineWidth: 2)
        }
    }

    @ViewBuilder
    private func getUnselection(unselectionStyle: GridSelectUnseletionStyle) -> some View {
        switch unselectionStyle {
        case .clean:
            EmptyView()
        case .surface:
            RoundedRectangle(
                cornerRadius: radius,
                style: .continuous
            )
            .fill(Color.surfaceSecondary)
            .overlay(
                RoundedRectangle(
                    cornerRadius: radius,
                    style: .continuous
                )
                .stroke(
                    theme.borderControls
                        ? Color.border
                        : Color.surfaceSecondary,
                    lineWidth: CGFloat(theme.borderSize)
                )
            )
        }
    }

    @ViewBuilder
    private func getSelectionIconDeprecated(icon: GridSelectSeletionIconStyle) -> some View {
        switch icon {
        case .none:
            EmptyView()
        case let .checkbox(alignment):
            ZStack(alignment: alignment) {
                Color.clear

                ZStack {
                    Circle()
                        .foregroundColor(Color.surfacePrimary)
                        .shadowElevation(.z2)
                    IconDeprecated(.checkMini, color: .onSurfacePrimary)
                }.frame(width: Space.large.rawValue, height: Space.large.rawValue)
                    .padding(.small)
            }
        case let .radio(alignment):
            ZStack(alignment: alignment) {
                Color.clear

                ZStack {
                    Circle()
                        .foregroundColor(Color.accent)
                        .shadowElevation(.z2)
                    Circle()
                        .frame(width: Space.small.rawValue, height: Space.small.rawValue)
                }.frame(width: Space.large.rawValue, height: Space.large.rawValue)
                    .padding(.small)
            }
        }
    }
}

public extension GridSelect where Selection == EmptyView {
    init(
        _ data: Data,
        selection: Binding<Data.Element>,
        radius: Radius = .medium,
        spacing: Space = .xSmall,
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        action: (() -> Void)? = nil
    ) {
        self.data = data
        self.content = content
        self.radius = radius
        self.spacing = spacing
        selectionView = { nil }
        self.action = action

        _selection = selection
        _frames = State(wrappedValue: Array(
            repeating: .zero,
            count: data.count
        ))
    }
}

// swiftlint:disable all
struct GridSelect_Preview: PreviewProvider {
    struct GridSelectPreview: View {
        var items = ["One", "Two", "Three", "Four"]

        @State var selection = ""

        var body: some View {
            Group {
                GridSelect(
                    items,
                    selection: $selection,
                    content: { item, _ in
                        VStack {
                            IconDeprecated(.circle)
                            Text(item)
                        }.padding()
                    }
                )
                .previewDisplayName("Default")

                GridSelect(
                    items,
                    selection: $selection,
                    content: { item, _ in
                        VStack {
                            IconDeprecated(.circle)
                            Text(item)
                        }.padding()
                    }
                )
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

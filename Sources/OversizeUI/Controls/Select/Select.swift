//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

// swiftlint:disable all
public struct Select<Element, Content, Selection>: View
    where
    Content: View,
    Selection: View
{
    @ObservedObject var appearanceSettings = AppearanceSettings.shared
    public typealias Data = [Element]

    @Binding private var selection: Data.Element
    private let data: Data
    private let label: String
    private let content: (Data.Element, Bool) -> Content
    @State private var selectedIndex: Data.Index? = 0
    private let selectionView: (Data.Element) -> Selection
    @State var showModal = false
    @State var isSelected = false

    public init(_ label: String,
                _ data: Data,
                selection: Binding<Data.Element>,
                @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
                @ViewBuilder selectionView: @escaping (Data.Element) -> Selection)
    {
        self.label = label
        self.data = data
        self.content = content
        self.selectionView = selectionView
        _selection = selection
    }

    public var body: some View {
        ZStack {
            Button {
                self.showModal.toggle()
            } label: {
                if isSelected, let index = selectedIndex {
                    selectionView(data[index])
                } else {
                    Text(label)
                }
                Spacer()
                Icon(.chevronDown, color: .onSurfaceHighEmphasis)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Radius.medium.rawValue,
                                 style: .continuous)
                    .fill(Color.surfaceSecondary)
                    .overlay(
                        RoundedRectangle(cornerRadius: Radius.medium.rawValue,
                                         style: .continuous)
                            .stroke(appearanceSettings.borderTextFields
                                ? Color.border
                                : Color.surfaceSecondary, lineWidth: CGFloat(appearanceSettings.borderSize))
                    )
            )
            .fontStyle(.subtitle1, color: .onSurfaceHighEmphasis)

            .sheet(isPresented: $showModal) {
                modal
            }
        }
    }

    private var modal: some View {
        NavigationView {
            List {
                ForEach(data.indices, id: \.self) { index in
                    Button(action: {
                               selectedIndex = index
                               selection = data[index]
                               isSelected = true
                               showModal.toggle()
                           },
                           label: {
                               content(data[index],
                                       selectedIndex == index)
                                   .fontStyle(.subtitle1,
                                              color: .onSurfaceHighEmphasis)

                           })
                }
            }.navigationTitle(label)
        }
    }
}

// swiftlint:disable all
struct Select_Preview: PreviewProvider {
    struct SelectPreview: View {
        var items = ["One", "Two", "Three", "Four"]

        @State var selection = ""

        var body: some View {
            VStack {
                Select("Select", items, selection: $selection) { item, _ in
                    Text(item)
                } selectionView: { selected in
                    Text(selected)
                }
                .previewDisplayName("Default")
            }
            .previewLayout(.sizeThatFits)
            .padding()
        }
    }

    static var previews: some View {
        SelectPreview()
    }
}

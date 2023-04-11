//
// Copyright © 2021 Alexander Romanov
// MultiSelect.swift, created on 10.02.2023
//

import SwiftUI

// swiftlint:disable all
public struct MultiSelect<Element: Equatable, Content, Selection>: View
    where
    Content: View,
    Selection: View
{
    @Environment(\.theme) private var theme: ThemeSettings
    public typealias Data = [Element]

    @Binding private var selection: Data
    private let data: Data
    private let label: String
    private let content: (Data.Element, Bool) -> Content
    private let selectionView: (Data) -> Selection
    @State private var showModal = false
    @State var selectedIndexes: [Int] = []

    public init(_ label: String,
                _ data: Data,
                selection: Binding<Data>,
                @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
                @ViewBuilder selectionView: @escaping (Data) -> Selection)
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
                showModal.toggle()
            } label: {
                if selectedIndexes.isEmpty {
                    Text(label)
                } else {
                    selectionView(selection)
                }
                Spacer()
                Icon(.chevronDown, color: .onSurfaceHighEmphasis)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Radius.medium,
                                 style: .continuous)
                    .fill(Color.surfaceSecondary)
                    .overlay(
                        RoundedRectangle(cornerRadius: Radius.medium,
                                         style: .continuous)
                            .stroke(theme.borderTextFields
                                ? Color.border
                                : Color.surfaceSecondary, lineWidth: CGFloat(theme.borderSize))
                    )
            )
            .headline()
            .foregroundColor(.onSurfaceHighEmphasis)
            .sheet(isPresented: $showModal) {
                #if os(iOS)
                if #available(iOS 16.0, *) {
                    modal
                        .presentationDetents(data.count < 4 ? [.medium, .large] : [.large])
                        .presentationDragIndicator(.hidden)
                } else {
                    modal
                }
                #else
                modal
                #endif
            }
        }
        .onAppear {
            if !selection.isEmpty {
                for dataIndex in 0 ..< data.count {
                    let dataItem = data[dataIndex]
                    for selectIndex in 0 ..< selection.count where dataItem == selection[selectIndex] {
                        selectedIndexes.append(dataIndex)
                    }
                }
            }
        }
    }

    private var modal: some View {
        PageView(label) {
            LazyVStack(alignment: .leading, spacing: .zero) {
                ForEach(data.indices, id: \.self) { index in
                    let isSelected = selectedIndexes.contains(index)

                    Checkbox(isOn:
                        Binding(get: {
                            isSelected
                        }, set: { _ in
                            if isSelected, let elementIndex = selectedIndexes.firstIndex(of: index) {
                                selectedIndexes.remove(at: elementIndex)
                            } else {
                                selectedIndexes.append(index)
                            }
                            let selectionItems = selectedIndexes.compactMap { data[$0] }
                            selection = selectionItems
                        }), label:  {
                            content(data[index], isSelected)
                        })
                }
            }
        }
        .leadingBar { BarButton(.close) }
    }
}

// swiftlint:disable all
struct MultiSelect_Preview: PreviewProvider {
    struct SelectPreview: View {
        var items = ["One", "Two", "Three", "Four"]

        @State var selection = [""]

        var body: some View {
            VStack {
                MultiSelect("Select", items, selection: $selection) { _, _ in
                    // Text(item)
                } selectionView: { _ in
                    // Text(selected)
                }
            }

            .padding()
        }
    }

    static var previews: some View {
        SelectPreview()
            .previewLayout(.sizeThatFits)
    }
}

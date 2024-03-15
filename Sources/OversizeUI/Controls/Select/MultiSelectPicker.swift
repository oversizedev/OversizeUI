//
// Copyright © 2024 Alexander Romanov
// MultiSelectPicker.swift, created on 03.03.2024
//

import SwiftUI

// swiftlint:disable all
@available(iOS 16.0, *)
public struct MultiSelectPicker<Element: Equatable, Content, Actions, ContentUnavailable>: View
    where
    Content: View,
    Actions: View,
    ContentUnavailable: View
{
    @Environment(\.dismiss) private var dismiss
    @Environment(\.multiSelectStyle) private var multiSelectStyle
    @Environment(\.theme) private var theme: ThemeSettings
    public typealias Data = [Element]

    @Binding private var selection: Data
    private let data: Data
    private let title: String
    private let content: (Data.Element, Bool) -> Content
    private let contentUnavailable: ContentUnavailable?
    @State var selectedIndexes: [Int] = []
    let actions: Group<Actions>?

    public init(
        _ title: String,
        _ data: Data,
        selection: Binding<Data>,
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        @ViewBuilder actions: @escaping () -> Actions,
        @ViewBuilder contentUnavailable: () -> ContentUnavailable
    ) {
        self.title = title
        self.data = data
        self.content = content
        self.actions = Group { actions() }
        self.contentUnavailable = contentUnavailable()
        _selection = selection
    }
    
    public var body: some View {
        Page(title) {
            if data.isEmpty, let contentUnavailable {
                contentUnavailable
            } else {
                pageContent(data, selectStyle: multiSelectStyle)
            }
    
        }
        .backgroundSecondary()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Image.Base.close.icon()
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                actions
            }
        }
        .onAppear {
            defaultSelect()
        }
    }
    
    private func defaultSelect() {
        if !selection.isEmpty {
            for dataIndex in 0 ..< data.count {
                let dataItem = data[dataIndex]
                for selectIndex in 0 ..< selection.count where dataItem == selection[selectIndex] {
                    selectedIndexes.append(dataIndex)
                }
            }
        }
    }
    
    @ViewBuilder
    private func pageContent(_ data: Data, selectStyle: MultiSelectStyle) -> some View {
        switch selectStyle {
        case .default:
            rowsList(data)
        case .section:
            SectionView {
                rowsList(data)
            }
            .sectionContentCompactRowMargins()
        }
    }
    
    private func rowsList(_ data: Data) -> some View {
        LazyVStack(alignment: .leading, spacing: .zero) {
            ForEach(data.indices, id: \.self) { index in
                let isSelected = selectedIndexes.contains(index)

                Checkbox(isOn: Binding(
                    get: { isSelected },
                    set: { _ in
                        if isSelected, let elementIndex = selectedIndexes.firstIndex(of: index) {
                            selectedIndexes.remove(at: elementIndex)
                        } else {
                            selectedIndexes.append(index)
                        }
                        let selectionItems = selectedIndexes.compactMap { data[$0] }
                        selection = selectionItems
                    }
                ), label: {
                    content(data[index], isSelected)
                })
            }
        }
    }
}

@available(iOS 16.0, *)
public extension MultiSelectPicker where ContentUnavailable == Never {
    init(
        _ title: String,
        _ data: Data,
        selection: Binding<Data>,
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        @ViewBuilder actions: @escaping () -> Actions
    ) {
        self.title = title
        self.data = data
        self.content = content
        self.actions = Group { actions() }
        contentUnavailable = nil
        _selection = selection
    }
}

@available(iOS 16.0, *)
public extension MultiSelectPicker where Actions == Never {
    init(
        _ title: String,
        _ data: Data,
        selection: Binding<Data>,
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        @ViewBuilder contentUnavailable: () -> ContentUnavailable
    ) {
        self.title = title
        self.data = data
        self.content = content
        actions = nil
        self.contentUnavailable = contentUnavailable()
        _selection = selection
    }
}

@available(iOS 16.0, *)
public extension MultiSelectPicker where ContentUnavailable == Never, Actions == Never {
    init(
        _ title: String,
        _ data: Data,
        selection: Binding<Data>,
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content
    ) {
        self.title = title
        self.data = data
        self.content = content
        actions = nil
        contentUnavailable = nil
        _selection = selection
    }
}

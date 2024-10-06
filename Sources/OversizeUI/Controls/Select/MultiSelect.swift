//
// Copyright © 2021 Alexander Romanov
// MultiSelect.swift, created on 10.02.2023
//

import SwiftUI

// swiftlint:disable all
@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
public struct MultiSelect<Element: Equatable, Content, Selection, Actions, ContentUnavailable>: View
    where
    Content: View,
    Selection: View,
    Actions: View,
    ContentUnavailable: View
{
    @Environment(\.theme) private var theme: ThemeSettings
    public typealias Data = [Element]

    @Binding private var selection: Data
    private let data: Data
    private let label: String
    private let content: (Data.Element, Bool) -> Content
    private let contentUnavailable: ContentUnavailable?
    private let selectionView: (Data) -> Selection
    @State private var showModal = false
    @Binding private var showModalBinding: Bool?
    @State var selectedIndexes: [Int] = []
    let actions: Group<Actions>?

    public init(
        _ label: String,
        _ data: Data,
        selection: Binding<Data>,
        activeModal: Binding<Bool?> = .constant(nil),
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        @ViewBuilder selectionView: @escaping (Data) -> Selection,
        @ViewBuilder actions: @escaping () -> Actions,
        @ViewBuilder contentUnavailable: () -> ContentUnavailable
    ) {
        self.label = label
        self.data = data
        self.content = content
        self.selectionView = selectionView
        self.actions = Group { actions() }
        self.contentUnavailable = contentUnavailable()
        _showModalBinding = activeModal
        _selection = selection
    }

    public var body: some View {
        ZStack {
            Button {
                if showModalBinding != nil {
                    showModalBinding?.toggle()
                } else {
                    showModal.toggle()
                }
            } label: {
                if selectedIndexes.isEmpty {
                    Text(label)
                } else {
                    selectionView(selection)
                }
                Spacer()
                IconDeprecated(.chevronDown, color: .onSurfaceHighEmphasis)
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
            .onChange(of: showModalBinding) { state in
                if let state {
                    showModal = state
                }
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
            if data.isEmpty, let contentUnavailable {
                contentUnavailable
            } else {
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
        .leadingBar { BarButton(.close) }
        .trailingBar { actions }
    }
}

@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
public extension MultiSelect where ContentUnavailable == Never {
    init(
        _ label: String,
        _ data: Data,
        selection: Binding<Data>,
        activeModal: Binding<Bool?> = .constant(nil),
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        @ViewBuilder selectionView: @escaping (Data) -> Selection,
        @ViewBuilder actions: @escaping () -> Actions
    ) {
        self.label = label
        self.data = data
        self.content = content
        self.selectionView = selectionView
        self.actions = Group { actions() }
        contentUnavailable = nil
        _showModalBinding = activeModal
        _selection = selection
    }
}

@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
public extension MultiSelect where Actions == Never {
    init(
        _ label: String,
        _ data: Data,
        selection: Binding<Data>,
        activeModal: Binding<Bool?> = .constant(nil),
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        @ViewBuilder selectionView: @escaping (Data) -> Selection,
        @ViewBuilder contentUnavailable: () -> ContentUnavailable
    ) {
        self.label = label
        self.data = data
        self.content = content
        self.selectionView = selectionView
        actions = nil
        self.contentUnavailable = contentUnavailable()
        _showModalBinding = activeModal
        _selection = selection
    }
}

@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
public extension MultiSelect where ContentUnavailable == Never, Actions == Never {
    init(
        _ label: String,
        _ data: Data,
        selection: Binding<Data>,
        activeModal: Binding<Bool?> = .constant(nil),
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        @ViewBuilder selectionView: @escaping (Data) -> Selection
    ) {
        self.label = label
        self.data = data
        self.content = content
        self.selectionView = selectionView
        actions = nil
        contentUnavailable = nil
        _showModalBinding = activeModal
        _selection = selection
    }
}

// swiftlint:disable all
@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
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

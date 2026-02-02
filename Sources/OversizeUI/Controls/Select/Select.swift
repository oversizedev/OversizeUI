//
// Copyright © 2021 Alexander Romanov
// Select.swift, created on 16.06.2020
//

import SwiftUI

// swiftlint:disable all
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct Select<Element: Equatable, Content: View, Selection: View, Actions: View, ContentUnavailable: View>: View {
    @Environment(\.theme) private var theme: ThemeSettings
    public typealias Data = [Element]

    @Binding private var selection: Data.Element
    @Binding private var showModalBinding: Bool?
    private let data: Data
    private let label: String
    private let content: (Data.Element, Bool) -> Content
    private let contentUnavailable: ContentUnavailable?
    @State private var selectedIndex: Data.Index? = 0
    private let selectionView: (Data.Element) -> Selection
    @State private var showModal = false
    @State private var isSelected = false
    let actions: Group<Actions>?

    public init(
        _ label: String,
        _ data: Data,
        selection: Binding<Data.Element>,
        activeModal: Binding<Bool?> = .constant(nil),
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        @ViewBuilder selectionView: @escaping (Data.Element) -> Selection,
        @ViewBuilder actions: @escaping () -> Actions,
        @ViewBuilder contentUnavailable: () -> ContentUnavailable
    ) {
        self.label = label
        self.data = data
        self.content = content
        self.selectionView = selectionView
        self.contentUnavailable = contentUnavailable()
        self.actions = Group { actions() }
        _showModalBinding = activeModal
        _selection = selection
    }

    public var body: some View {
        Button {
            if showModalBinding != nil {
                showModalBinding?.toggle()
            } else {
                showModal.toggle()
            }
        } label: {
            HStack(spacing: .zero) {
                if isSelected, let index = selectedIndex {
                    selectionView(data[index])
                } else {
                    Text(label)
                }
                Spacer()
                IconDeprecated(.chevronDown, color: .onSurfacePrimary)
            }
        }
        .buttonStyle(.field)
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
        .onAppear {
            let selctedValue = selection
            var index = 0
            for dataValue in data {
                if selctedValue == dataValue {
                    selectedIndex = index
                }
                index += 1
            }
        }
    }

    private var modal: some View {
        NavigationStack {
            LayoutView(label) {
                if data.isEmpty, let contentUnavailable {
                    contentUnavailable
                } else {
                    LazyVStack(alignment: .leading, spacing: .zero) {
                        ForEach(data.indices, id: \.self) { index in
                            Radio(isOn: index == selectedIndex) {
                                selectedIndex = index
                                selection = data[index]
                                isSelected = true
                                showModal.toggle()
                            } label: {
                                content(
                                    data[index],
                                    selectedIndex == index
                                )
                                .headline()
                                .onSurfacePrimary()
                            }
                        }
                    }
                }
            }
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") {
                        showModal = false
                    }
                    .labelStyle(.toolbar)
                    .buttonStyle(.toolbarSecondary)
                }

                ToolbarItem(placement: .confirmationAction) {
                    actions
                }
            }
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public extension Select where ContentUnavailable == Never {
    init(
        _ label: String,
        _ data: Data,
        selection: Binding<Data.Element>,
        activeModal: Binding<Bool?> = .constant(nil),
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        @ViewBuilder selectionView: @escaping (Data.Element) -> Selection,
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

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public extension Select where Actions == Never {
    init(
        _ label: String,
        _ data: Data,
        selection: Binding<Data.Element>,
        activeModal: Binding<Bool?> = .constant(nil),
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        @ViewBuilder selectionView: @escaping (Data.Element) -> Selection,
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

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public extension Select where ContentUnavailable == Never, Actions == Never {
    init(
        _ label: String,
        _ data: Data,
        selection: Binding<Data.Element>,
        activeModal: Binding<Bool?> = .constant(nil),
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        @ViewBuilder selectionView: @escaping (Data.Element) -> Selection
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
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
struct SelectNew_Preview: PreviewProvider {
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
            }
            .padding()
        }
    }

    static var previews: some View {
        SelectPreview()
            .previewLayout(.sizeThatFits)
    }
}

//
// Copyright © 2021 Alexander Romanov
// Select.swift, created on 16.06.2020
//

import SwiftUI

// swiftlint:disable all
@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
public struct Select<Element: Equatable, Content, Selection, Actions, ContentUnavailable: View>: View
    where
    Content: View,
    Actions: View,
    Selection: View
{
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
        ZStack {
            Button {
                if showModalBinding != nil {
                    showModalBinding?.toggle()
                } else {
                    showModal.toggle()
                }
            } label: {
                if isSelected, let index = selectedIndex {
                    selectionView(data[index])
                } else {
                    Text(label)
                }
                Spacer()
                IconDeprecated(.chevronDown, color: .onSurfacePrimary)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: Radius.medium,
                    style: .continuous
                )
                .fill(Color.surfaceSecondary)
                .overlay(
                    RoundedRectangle(
                        cornerRadius: Radius.medium,
                        style: .continuous
                    )
                    .stroke(
                        theme.borderTextFields
                            ? Color.border
                            : Color.surfaceSecondary,
                        lineWidth: CGFloat(theme.borderSize)
                    )
                )
            )
            .headline(.medium)
            .foregroundColor(.onSurfacePrimary)
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
    }

    private var modal: some View {
        PageView(label) {
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
                            .onSurfacePrimaryForeground()
                        }
                    }
                }
            }
        }
        .leadingBar { BarButton(.close) }
        .trailingBar { actions }
    }
}

@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
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

@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
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

@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
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
@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
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
            }
            .padding()
        }
    }

    static var previews: some View {
        SelectPreview()
            .previewLayout(.sizeThatFits)
    }
}

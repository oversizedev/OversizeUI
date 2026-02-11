//
// Copyright © 2024 Alexander Romanov
// SelectPicker.swift, created on 29.02.2024
//

import SwiftUI

// swiftlint:disable all
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct SelectPicker<Element: Hashable, Content: View, Actions: View, ContentUnavailable: View>: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.selectStyle) private var selectStyle
    public typealias Data = [Element]

    @Binding private var selection: Data.Element
    private let data: Data
    private let title: String?
    private let content: (Data.Element, Bool) -> Content
    private let contentUnavailable: ContentUnavailable?
    @State private var selectedIndex: Data.Index? = nil
    let actions: Group<Actions>?

    public init(
        _ title: String? = nil,
        _ data: Data,
        selection: Binding<Data.Element>,
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        @ViewBuilder actions: @escaping () -> Actions,
        @ViewBuilder contentUnavailable: () -> ContentUnavailable
    ) {
        self.title = title
        self.data = data
        self.content = content
        self.contentUnavailable = contentUnavailable()
        self.actions = Group { actions() }
        _selection = selection
    }

    public var body: some View {
        LayoutView(title ?? "") {
            if data.isEmpty, let contentUnavailable {
                contentUnavailable
            } else {
                pageContent(data, selectStyle: selectStyle)
            }
        } background: {
            Color.backgroundSecondary
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(
                    "Close",
                    systemImage: "xmark",
                    role: .cancel,
                    action: {
                        dismiss()
                    }
                )
                .labelStyle(.toolbar)
                .buttonStyle(.toolbarSecondary)
                #if !os(tvOS)
                    .keyboardShortcut(.cancelAction)
                #endif
            }

            ToolbarItem(placement: .confirmationAction) {
                actions
            }
        }
        .toolbarTitleDisplayMode(.inline)
        .onAppear {
            defaultSelect()
        }
    }

    @ViewBuilder
    private func pageContent(_ data: Data, selectStyle: SelectStyle) -> some View {
        switch selectStyle {
        case .default:
            rowsList(data)
        case .section:
            SectionView {
                rowsList(data)
            }
            .sectionContentCompactRowMargins()
        case .wheel:
            #if os(iOS)
            SectionView {
                wheelList(data)
            }
            #else
            rowsList(data)
            #endif
        }
    }

    #if os(iOS)
    private func wheelList(_ data: Data) -> some View {
        Picker("", selection: $selection) {
            ForEach(data, id: \.self) { item in
                content(item, selection == item)
            }
        }
        .labelsHidden()
        .pickerStyle(.wheel)
    }
    #endif

    private func rowsList(_ data: Data) -> some View {
        LazyVStack(alignment: .leading, spacing: .zero) {
            ForEach(data.indices, id: \.self) { index in
                Radio(isOn: index == selectedIndex) {
                    selectedIndex = index
                    selection = data[index]
                    dismiss()
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

    private func defaultSelect() {
        var index = 0
        for dataValue in data {
            if selection == dataValue {
                selectedIndex = index
            }
            index += 1
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public extension SelectPicker where ContentUnavailable == Never {
    init(
        _ title: String? = nil,
        _ data: Data,
        selection: Binding<Data.Element>,
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

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public extension SelectPicker where Actions == Never {
    init(
        _ title: String? = nil,
        _ data: Data,
        selection: Binding<Data.Element>,
        activeModal _: Binding<Bool?> = .constant(nil),
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

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public extension SelectPicker where ContentUnavailable == Never, Actions == Never {
    init(
        _ title: String? = nil,
        _ data: Data,
        selection: Binding<Data.Element>,
        activeModal _: Binding<Bool?> = .constant(nil),
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

//
// Copyright © 2021 Alexander Romanov
// IconField.swift, created on 02.04.2022
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct IconField: View {
    @Environment(\.theme) private var theme: ThemeSettings

    private let label: String
    private let icons: [Image]
    @Binding private var selection: Image?
    @State private var showModal = false
    @State private var selectedIndex: Int?

    var style: IconPickerStyle = .field

    public init(
        _ label: String,
        icons: [Image],
        selection: Binding<Image?>
    ) {
        self.label = label
        self.icons = icons
        _selection = selection
    }

    public var body: some View {
        Group {
            switch style {
            case .field:
                fieldView
            case .circle:
                circleView
            }
        }
        .sheet(isPresented: $showModal) {
            modal
                .presentationDetents([.medium, .large])
        }
    }

    // MARK: - Views

    public var circleView: some View {
        Button {
            showModal.toggle()
        } label: {
            Group {
                if let image = selection {
                    image
                } else {
                    Image.Base.edit.icon(size: .large)
                }
            }
            .padding(.xxSmall)
        }
        .buttonStyle(.iconTertiary)
        .controlSize(.extraLarge)
    }

    private var fieldView: some View {
        Button {
            showModal.toggle()
        } label: {
            HStack(spacing: .xxSmall) {
                Text(label)
                    .onSurfacePrimary()

                Spacer()
                if let image = selection {
                    image
                }
                Image.Base.chevronDown.icon(.onSurfacePrimary)
            }
        }
        .buttonStyle(.field)
    }

    private var modal: some View {
        NavigationStack {
            LayoutView(label) {
                IconPicker(icons: icons, selectedIndex: $selectedIndex)
            }
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        showModal = false
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let index = selectedIndex {
                            selection = icons[index]
                        }
                        showModal = false
                    }
                }
            }
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public extension IconField {
    func iconPickerStyle(_ style: IconPickerStyle) -> Self {
        var control = self
        control.style = style
        return control
    }
}

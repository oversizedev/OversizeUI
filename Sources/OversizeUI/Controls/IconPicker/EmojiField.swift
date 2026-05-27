//
// Copyright © 2025 Alexander Romanov
// EmojiField.swift, created on 11.08.2025
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct EmojiField: View {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.dismiss) private var dismiss

    private let label: String
    private let emojis: [String]
    @Binding private var selection: String
    @State private var showModal = false

    var style: IconPickerStyle = .field

    public init(
        _ label: String,
        emojis: [String],
        selection: Binding<String>
    ) {
        self.label = label
        self.emojis = emojis.compactMap { $0.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\n", with: "") }
        _selection = selection
    }

    public init(
        _ label: String,
        emojis: String,
        selection: Binding<String>
    ) {
        self.label = label
        self.emojis = emojis.replacingOccurrences(of: "\n", with: "").map { String($0) }
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
            modalView
                .presentationDetents([.medium, .large])
        }
    }

    // MARK: - Views

    private var circleView: some View {
        Button {
            showModal.toggle()
        } label: {
            Text(selection.isEmpty ? "😀" : selection)
                .font(.system(size: 32))
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

                if !selection.isEmpty {
                    Text(selection)
                        .font(.system(size: 24))
                }

                Image.Base.chevronDown.icon(.onSurfacePrimary)
            }
        }
        .buttonStyle(.field)
    }

    private var modalView: some View {
        NavigationStack {
            LayoutView(label) {
                EmojiPicker(emojis: emojis, selection: $selection)
                    .onChange(of: selection) { showModal = false }
            }
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { dismiss() }) {
                        Image.Base.close.icon()
                    }
                }
            }
        }
    }
}

// MARK: - View Modifiers

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public extension EmojiField {
    func iconPickerStyle(_ style: IconPickerStyle) -> some View {
        var view = self
        view.style = style
        return view
    }
}

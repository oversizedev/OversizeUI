//
// Copyright © 2025 Alexander Romanov
// EmojiPicker.swift, created on 11.08.2025
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct EmojiPicker: View {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.dismiss) private var dismiss

    private let label: String
    private let emojis: [String]
    @Binding private var selection: String
    @State private var showModal = false

    var style: IconPickerStyle = .field

    private var gridPadding: CGFloat {
        switch horizontalSizeClass {
        case .compact, .none:
            60
        default:
            72
        }
    }

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
                ScrollView {
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: gridPadding))],
                        spacing: .small
                    ) {
                        ForEach(Array(emojis.enumerated()), id: \.offset) { _, emoji in
                            emojiButton(emoji: emoji)
                        }
                    }
                    .padding(.top, .medium)
                    .paddingContent(.horizontal)
                    .paddingContent(.bottom)
                }
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

    private func emojiButton(emoji: String) -> some View {
        Button {
            selection = emoji
            showModal = false
        } label: {
            Text(emoji)
                .font(.system(size: 28))
                .frame(width: 56, height: 56)
                .background(
                    RoundedRectangle(cornerRadius: .xSmall, style: .continuous)
                        .fill(selection == emoji ? Color.primary.opacity(0.08) : Color.clear)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: .xSmall, style: .continuous)
                        .strokeBorder(
                            selection == emoji ? Color.accentColor : Color.clear,
                            lineWidth: 2
                        )
                )
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - View Modifiers

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public extension EmojiPicker {
    func iconPickerStyle(_ style: IconPickerStyle) -> some View {
        var view = self
        view.style = style
        return view
    }
}

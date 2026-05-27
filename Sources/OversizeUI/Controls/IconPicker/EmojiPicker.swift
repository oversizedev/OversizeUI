//
// Copyright © 2025 Alexander Romanov
// EmojiPicker.swift, created on 11.08.2025
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct EmojiPicker: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private let emojis: [String]
    @Binding private var selection: String

    private var gridPadding: CGFloat {
        switch horizontalSizeClass {
        case .compact, .none:
            60
        default:
            72
        }
    }

    public init(emojis: [String], selection: Binding<String>) {
        self.emojis = emojis.compactMap { $0.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\n", with: "") }
        _selection = selection
    }

    public init(emojis: String, selection: Binding<String>) {
        self.emojis = emojis.replacingOccurrences(of: "\n", with: "").map { String($0) }
        _selection = selection
    }

    public var body: some View {
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

    private func emojiButton(emoji: String) -> some View {
        Button {
            selection = emoji
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

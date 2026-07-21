//
// Copyright © 2021 Alexander Romanov
// RowButton.swift, created on 20.06.2020
//

import SwiftUI

public struct ListButton: View {
    /// Environment value indicating if accent styling should be applied.
    @Environment(\.isAccent) private var isAccent: Bool

    /// Environment value indicating if the button is in loading state.
    @Environment(\.isLoading) private var isLoading: Bool

    public var text: String
    public var tapAction: () -> Void
    private let role: ButtonRole?

    public init(
        _ text: String,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.role = role
        tapAction = action
    }

    public var body: some View {
        Button(role: role, action: tapAction) {
            Text(text)
                .frame(maxWidth: .infinity)
                .body(.semibold)
                .foregroundColor(foregroundColor(for: role).opacity(labelOpacity))
        }
        .overlay(loadingView(for: role))
    }

    @ViewBuilder
    private func loadingView(for role: ButtonRole?) -> some View {
        if isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: foregroundColor(for: role)))
        }
    }

    private var labelOpacity: CGFloat {
        isLoading ? 0 : 1
    }

    private func foregroundColor(for role: ButtonRole?) -> Color {
        switch role {
        case .some(.destructive): Color.error
        case .some(.cancel): Color.accent
        default:
            if isAccent {
                Color.accent
            } else {
                Color.onSurfacePrimary
            }
        }
    }
}

// MARK: - Preview

// swiftlint:disable all
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("ListLayout Grouped") {
    NavigationView {
        ListLayoutView("Settings") {
            ListSection("Actions") {
                ListRow("Share journal", leading: {
                    Image(systemName: "square.and.arrow.up").icon()
                })

                ListRow("Export PDF", leading: {
                    Image(systemName: "doc.richtext").icon()
                })

                ListButton("Sync") {}
                    .loading(true)
                    .controlSize(.small)
            }

            ListSection("Danger Zone") {
                ListRow("Clear history", leading: {
                    Image(systemName: "clock.arrow.circlepath").icon()
                })

                ListButton("Delete all entries", role: .destructive) {}
            }

            ListSection {
                ListButton("Sign out") {}
                    .accent()
            }
        }
        .listLayoutStyle(.insetGrouped)
        .toolbarTitleDisplayMode(.inline)
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("ListLayout Plain") {
    NavigationView {
        ListLayoutView("Actions") {
            ListSection {
                ListRow("Share journal", leading: {
                    Image(systemName: "square.and.arrow.up").icon()
                }, trailing: {
                    Button("Share") {}
                        .controlSize(.small)
                })

                ListRow("Export PDF", leading: {
                    Image(systemName: "doc.richtext").icon()
                }, trailing: {
                    Button("Export") {}
                        .controlSize(.small)
                })
            }

            ListSection {
                ListButton("Delete all entries", role: .destructive) {}

                ListButton("Sign out") {}
                    .accent()
            }
        }
        .toolbarTitleDisplayMode(.inline)
    }
}

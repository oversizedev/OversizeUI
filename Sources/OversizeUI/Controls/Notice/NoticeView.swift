//
// Copyright © 2021 Alexander Romanov
// NoticeView.swift, created on 12.09.2022
//

import SwiftUI

/// Display alert banners and notifications with customizable styling and actions.
///
/// Use `NoticeView` to present important information, alerts, and notifications to users.
/// It supports various styles, custom actions, and maintains accessibility standards.
///
/// ```swift
/// NoticeView("Operation completed successfully!")
/// ```
///
/// ```swift
/// NoticeView("Update Available", subtitle: "A new version is available.") {
///     Button("Update") { performUpdate() }
///         .buttonStyle(.primary)
///         .controlSize(.small)
/// } closeAction: {
///     dismissNotice()
/// }
/// ```
///
/// ## Topics
///
/// ### Creating a Notice
/// - ``init(_:subtitle:image:imageURL:actions:closeAction:)``
/// - ``init(_:subtitle:image:imageURL:closeAction:)``
///
/// ### Styling
/// - ``noticeStyle(_:)``
///
/// ## See Also
/// - <doc:Components/NoticeView>
/// - ``Button``
/// - ``Surface``
public struct NoticeView<A>: View where A: View {
    /// The image displayed in the notice.
    let image: Image?
    
    /// The URL for an image to be displayed in the notice.
    let imageURL: URL?
    
    /// The title text of the notice.
    let title: String
    
    /// The subtitle text providing additional information.
    let subtitle: String?
    
    /// Custom actions displayed in the notice.
    let actions: Group<A>?
    
    /// The closure executed when the close button is tapped.
    let closeAction: (() -> Void)?

    /// Creates a notice view with title, subtitle, optional image, actions, and close functionality.
    ///
    /// - Parameters:
    ///   - title: The main title text for the notice
    ///   - subtitle: Optional subtitle providing additional context
    ///   - image: Optional image to display alongside the content
    ///   - imageURL: Optional URL for loading an image asynchronously
    ///   - actions: Custom action buttons or controls
    ///   - closeAction: Optional closure called when the notice is dismissed
    public init(
        _ title: String,
        subtitle: String? = nil,
        image: Image? = nil,
        imageURL: URL? = nil,
        @ViewBuilder actions: @escaping () -> A,
        closeAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.imageURL = imageURL
        self.actions = Group { actions() }
        self.closeAction = closeAction
    }

    public var body: some View {
        Surface {
            VStack(alignment: .leading, spacing: .xxSmall) {
                HStack(spacing: .xSmall) {
                    image.map {
                        $0
                            .resizable()
                            .frame(width: 32, height: 32)
                    }

                    imageURL.map { url in
                        AsyncImage(url: url) {
                            $0
                                .resizable()
                                .frame(width: 32, height: 32)
                        } placeholder: {
                            Circle()
                                .fillBackgroundTertiary()
                                .frame(width: 32, height: 32)
                        }
                    }

                    Text(title)
                        .headline(.semibold)
                        .onSurfacePrimaryForeground()
                        .multilineTextAlignment(.leading)
                        .padding(.trailing, closeAction != nil ? .medium : .zero)
                }

                subtitle.map { text in
                    Text(text)
                        .body(.medium)
                        .onSurfaceSecondaryForeground()
                        .multilineTextAlignment(.leading)
                }

                #if os(iOS)
                if actions != nil {
                    HStack(spacing: .small) {
                        actions
                            .buttonStyle(.primary)
                            .controlSize(.small)
                    }
                    .padding(.top, .xxSmall)
                }
                #endif
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .overlay(alignment: .topTrailing) {
            #if os(iOS)
            if closeAction != nil {
                Button {
                    closeAction?()
                } label: {
                    IconDeprecated(.xMini, color: .onSurfacePrimary)
                }
                .buttonStyle(subtitle != nil ? .tertiary(infinityWidth: false) : .quaternary(infinityWidth: false))
                .controlBorderShape(.capsule)
                .padding(.small)
                .controlSize(.mini)
            }
            #endif
        }
    }
}

public extension NoticeView where A == EmptyView {
    init(
        _ title: String,
        subtitle: String? = nil,
        image: Image? = nil,
        imageURL: URL? = nil,
        closeAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.imageURL = imageURL
        actions = nil
        self.closeAction = closeAction
    }
}

struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: .small) {
            NoticeView("Title")

            NoticeView("Title", subtitle: "Subtitle")

            NoticeView("Title", subtitle: "Subtitle") {
                print("Close action")
            }

            NoticeView("Title") {
                Button {
                    print("Primay action")
                } label: {
                    Text("Primay")
                }
                .accent()
            }

            NoticeView("Title", subtitle: "Subtitle") {
                Button("Primay") {
                    print("Primay action")
                }
                Button("Secondary") {
                    print("Secondary action")
                }
                .buttonStyle(.tertiary)
            } closeAction: {
                print("Close")
            }
        }
        .padding()
        .background { Color.backgroundSecondary.ignoresSafeArea(.all) }
    }
}

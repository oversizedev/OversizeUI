//
// Copyright © 2021 Alexander Romanov
// NoticeView.swift, created on 12.09.2022
//

import SwiftUI

public struct NoticeView<A>: View where A: View {
    let image: Image?
    let imageURL: URL?
    let title: String
    let subtitle: String?
    let actions: Group<A>?
    let closeAction: (() -> Void)?

    public init(_ title: String,
                subtitle: String? = nil,
                image: Image? = nil,
                imageURL: URL? = nil,
                @ViewBuilder actions: @escaping () -> A,
                closeAction: (() -> Void)? = nil)
    {
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
                    IconDeprecated(.xMini, color: .onSurfaceHighEmphasis)
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
    init(_ title: String,
         subtitle: String? = nil,
         image: Image? = nil,
         imageURL: URL? = nil,
         closeAction: (() -> Void)? = nil)
    {
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

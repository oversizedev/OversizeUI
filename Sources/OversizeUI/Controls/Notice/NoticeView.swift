//
// Copyright © 2022 Alexander Romanov
// NoticeView.swift
//

import SwiftUI

public struct NoticeView<A>: View where A: View {
    let image: Image?
    let title: String
    let subtitle: String?
    let actions: Group<A>?
    let closeAction: (() -> Void)?

    public init(_ title: String,
                subtitle: String? = nil,
                image: Image? = nil,
                @ViewBuilder actions: @escaping () -> A,
                closeAction: (() -> Void)? = nil)
    {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.actions = Group { actions() }
        self.closeAction = closeAction
    }

    public var body: some View {
        Surface {
            VStack(alignment: .leading, spacing: .xxSmall) {
                HStack {
                    image.map {
                        $0
                            .resizable()
                            .frame(width: 32, height: 32)
                    }

                    Text(title)
                        .headline(.bold)
                        .foregroundOnSurfaceHighEmphasis()
                        .multilineTextAlignment(.leading)
                        .padding(.trailing, closeAction != nil ? .medium : .zero)
                }

                subtitle.map { text in
                    Text(text)
                        .body(.medium)
                        .foregroundOnSurfaceMediumEmphasis()
                        .multilineTextAlignment(.leading)
                }

                if actions != nil {
                    HStack(spacing: .xSmall) {
                        actions
                            .buttonStyle(.primary)
                            .controlSize(.mini)
                    }
                    .padding(.top, .xxSmall)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .overlay(alignment: .topTrailing) {
            if closeAction != nil {
                Button {
                    closeAction?()
                } label: {
                    Icon(.xMini, color: .onSurfaceHighEmphasis)
                }
                .buttonStyle(.tertiary(infinityWidth: false))
                .controlBorderShape(.capsule)
                .padding(.xSmall)
                .controlSize(.mini)
            }
        }
    }
}

public extension NoticeView where A == EmptyView {
    init(_ title: String,
         subtitle: String? = nil,
         image: Image? = nil,
         closeAction: (() -> Void)? = nil)
    {
        self.image = image
        self.title = title
        self.subtitle = subtitle
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
                    print("Ok Action")
                }

                NoticeView("Title") {
                    Button {
                        print("Ok")
                    } label: {
                        Text("Primay")
                    }
                    .accent()
                }

                NoticeView("Title", subtitle: "Subtitle") {
                    Button("Primay") {
                        print("Ok")
                    }
                    Button("Primay") {
                        print("Ok")
                    }
                    .buttonStyle(.tertiary)

                } closeAction: {
                    print("Close")
                }
            }
            .padding()
            .background {  Color.backgroundSecondary.ignoresSafeArea(.all) }
        
    }
}

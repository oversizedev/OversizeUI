//
// Copyright © 2021 Alexander Romanov
// IconsDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct IconsDemo: View {
    private let columns = [GridItem(.adaptive(minimum: 44), spacing: .small)]

    private let icons: [(String, Image)] = [
        ("activity", Image.Base.activity),
        ("bag", Image.Base.bag),
        ("bookmark", Image.Base.bookmark),
        ("calendar", Image.Base.calendar),
        ("camera", Image.Base.camera),
        ("category", Image.Base.category),
        ("chart", Image.Base.chart),
        ("chat", Image.Base.chat),
        ("check", Image.Base.check),
        ("clock", Image.Base.clock),
        ("close", Image.Base.close),
        ("delete", Image.Base.delete),
        ("document", Image.Base.document),
        ("download", Image.Base.download),
        ("edit", Image.Base.edit),
        ("eye", Image.Base.eye),
        ("filter", Image.Base.filter),
        ("folder", Image.Base.folder),
        ("heart", Image.Base.heart),
        ("home", Image.Base.home),
        ("info", Image.Base.info),
        ("link", Image.Base.link),
        ("location", Image.Base.location),
        ("lock", Image.Base.lock),
        ("message", Image.Base.message),
        ("notification", Image.Base.notification),
        ("profile", Image.Base.profile),
        ("search", Image.Base.search),
        ("send", Image.Base.send),
        ("setting", Image.Base.setting),
        ("star", Image.Base.star),
        ("upload", Image.Base.upload),
        ("wallet", Image.Base.wallet),
        ("work", Image.Base.work),
    ]

    var body: some View {
        DemoScreen {
            DemoSectionView("Sizes") {
                HStack(spacing: .small) {
                    Icon(Image.Base.star)
                        .iconSize(.xSmall)

                    Icon(Image.Base.star)
                        .iconSize(.small)

                    Icon(Image.Base.star)

                    Icon(Image.Base.star)
                        .iconSize(.large)
                }
            }

            DemoSectionView("SF Symbols") {
                HStack(spacing: .small) {
                    Icon("swift")

                    Icon("bolt.fill")
                        .iconColor(.accent)
                }
            }

            DemoSectionView("Image.Base") {
                LazyVGrid(columns: columns, spacing: .small) {
                    ForEach(icons, id: \.0) { name, image in
                        Icon(image)
                            .accessibilityIdentifier(name)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        IconsDemo()
    }
}

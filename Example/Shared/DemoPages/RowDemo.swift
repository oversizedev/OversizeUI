//
// Copyright © 2022 Alexander Romanov
// RowDemo.swift
//

import OversizeUI
import SwiftUI

// swiftlint:disable all
struct RowDemo: View {
    var body: some View {
        VStack {
            Row("Title")

            Row("Title", subtitle: "Subtitle")

            Row("Title", subtitle: "Subtitle", leadingType: .icon(.calendar), trallingType: .radio, paddingVertical: .medium)

            Row("Title", subtitle: "Subtitle", leadingType: .icon(.calendar), trallingType: .radio, paddingVertical: .small)
        }
    }
}

struct RowDemo_Previews: PreviewProvider {
    static var previews: some View {
        RowDemo()
    }
}

//
// Copyright © 2022 Alexander Romanov
// RowDemo.swift
//

import OversizeUI
import SwiftUI

// swiftlint:disable all
struct RowDemo: View {
    @State var radioOne: Bool = false
    @State var radioTwo: Bool = false

    var body: some View {
        VStack {
            Row("Title")

            Row("Title", subtitle: "Subtitle")

            Row("Title", subtitle: "Subtitle", leadingType: .icon(.calendar), trallingType: .radio(isOn: $radioOne), paddingVertical: .medium)

            Row("Title", subtitle: "Subtitle", leadingType: .icon(.calendar), trallingType: .radio(isOn: $radioTwo), paddingVertical: .small)
        }
    }
}

struct RowDemo_Previews: PreviewProvider {
    static var previews: some View {
        RowDemo()
    }
}

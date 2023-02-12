//
// Copyright © 2021 Alexander Romanov
// RowDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

// swiftlint:disable all
struct RowDemo: View {
    @State var radioOne: Bool = false
    @State var radioTwo: Bool = false

    var body: some View {
        PageView("Rows") {
            VStack {
                Row("Title")
                
                Row("Title", subtitle: "Subtitle")
            }
        }
        .leadingBar {
            BarButton(.back)
        }
    }
}

struct RowDemo_Previews: PreviewProvider {
    static var previews: some View {
        RowDemo()
    }
}

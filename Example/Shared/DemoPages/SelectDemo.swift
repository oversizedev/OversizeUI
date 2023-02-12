//
// Copyright © 2021 Alexander Romanov
// SelectDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct SelectDemo: View {
    var items = ["One", "Two", "Three", "Four"]

    @State var selection = ""

    var body: some View {
        PageView("Select") {
            VStack {
                Select("Select", items, selection: $selection) { item, isSelect in
                    Radio(item, isOn: isSelect)
                } selectionView: { selected in
                    Text(selected)
                }
            }
            .padding()
        }
        .leadingBar {
            BarButton(.back)
        }
        
    }
}

struct SelectDemo_Previews: PreviewProvider {
    static var previews: some View {
        SelectDemo()
    }
}

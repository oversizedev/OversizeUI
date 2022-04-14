//
// Copyright © 2022 Alexander Romanov
// PageDemo.swift
//

import OversizeUI
import SwiftUI

struct PageDemo: View {
    @Environment(\.screenSize) var screenSize
    @State var isShowModal = false

    var body: some View {
        PageView("Page view") {
            VStack {
                Button {
                    isShowModal = true
                } label: {
                    Text("Show modal")
                }

                ForEach((1 ... 100).reversed(), id: \.self) { item in

                    HStack {
                        Spacer()
                        Text("Item number \(item)")
                        Spacer()
                    }
                    .padding()
                }
            }
        }
        .leadingBar {
            BarButton(type: .back)
        }
        .trailingBar {
            BarButton(type: .primary("Save", action: {}))
        }
        .topToolbar {
            Text("Top")
        }
        .bottomToolbar {
            Text("Bottom")
                .padding(.bottom, screenSize.safeAreaBottom)
        }
        .sheet(isPresented: $isShowModal) {
            IconsDemo()
        }
    }
}

struct PageDemo_Previews: PreviewProvider {
    static var previews: some View {
        PageDemo()
    }
}

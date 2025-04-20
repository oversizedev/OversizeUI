//
// Copyright © 2021 Alexander Romanov
// PageDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

#if os(iOS)
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
                BarButton(.back)
            }
            .trailingBar {
                BarButton(.primary("Save", action: {}))
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
#endif

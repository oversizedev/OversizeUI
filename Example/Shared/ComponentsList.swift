//
// Copyright © 2021 Alexander Romanov
// ComponentsList.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct Page: Identifiable {
    let id: UUID = .init()
    let name: String
    let page: AnyView
}

// swiftlint:disable all
struct ComponentsList: View {
    @State var isShowSettings = false

    @State var updater: Bool = false

    @State var isShowSetting = false

    #if os(iOS)
        let pages = [
            Page(name: "Buttons", page: AnyView(ButtonsDemo())),
            Page(name: "ColorSelector", page: AnyView(ColorSelect())),
            Page(name: "Avatar", page: AnyView(AvatarDemo())),
            Page(name: "GridSelect", page: AnyView(GridSelectDemo())),
            Page(name: "TextField", page: AnyView(TextFieldDemo())),
            Page(name: "Icons", page: AnyView(IconsDemo())),
            Page(name: "Row", page: AnyView(RowDemo())),
            Page(name: "SegmentedControl", page: AnyView(SegmentedControlDemo())),
            Page(name: "Select", page: AnyView(SelectDemo())),
            Page(name: "Surface", page: AnyView(SurfaceDemo())),
            Page(name: "Page", page: AnyView(PageDemo())),
        ]
    #endif

    var body: some View {
        #if os(iOS)
            PageView("Example") {
                VStack(spacing: .zero) {
                    ForEach(pages) { page in
                        NavigationLink(destination: page.page) {
                            Row(page.name)
                        }
                        .buttonStyle(.row)
                    }
                }
            }
            .navigationable()
        #else
            Text("Support will be in the future")
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentsList()
    }
}

struct SegmentedControlPreview: View {
    @State var offset = CGPoint(x: 0, y: 0)

    @State var selectedItem: String = ""

    var items = ["One", "Two", "Three"]

    @State var selection = ""

    var body: some View {
        ScrollView {
            VStack {
                Group {
                    Text("ffff")
                    Text("ffff")
                    Text("ffff")
                    Text("ffff")
                    Text("ffff")
                    Text("ffff")
                    Text("ffff")
                    Text("ffff")
                    Text("ffff")
                    Text("ffff")
                }.padding()
                Group {
                    Text("ffff")
                    Text("ffff")
                    Text("ffff")
                    Text("ffff")
                    Text("ffff")
                    Text("ffff")
                    Text("ffff")
                    Text("ffff")
                    Text("ffff")
                    Text("ffff")
                }.padding()
                Text(selection)

                HStack {
                    SegmentedPickerSelector(items, selection: $selection) { item, _ in
                        Text(item)
                    }
                    .segmentedControlStyle(IslandSegmentedControlStyle())
                    Spacer()
                }

                HStack {
                    SegmentedPickerSelector(items, selection: $selection) { item, _ in
                        Text(item)
                    }
                    .segmentedControlStyle(IslandSegmentedControlStyle())
                    Spacer()
                }

                Spacer()
            }.padding()
        }
        .scrollWithNavigationBar("App", style: .fixed($offset), background: Color.backgroundSecondary) {
            BarButton(.back)
        } trailingBar: {} bottomBar: {}
    }
}

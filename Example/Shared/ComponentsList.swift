//
// Copyright © 2022 Alexander Romanov
// ComponentsList.swift
//

import OversizeUI
import SwiftUI

struct Page: Identifiable {
    let id = UUID()
    let name: String
    let page: AnyView
}

// swiftlint:disable all
struct ComponentsList: View {
    @State var isShowSettings = false

    @State var updater: Bool = false

    @State var isShowSetting = false

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

    var body: some View {
        PageView("Example") {
            ForEach(pages) { page in
                HStack {
                    NavigationLink(page.name, destination: page.page)
                        .fontStyle(.button, color: .onSurfaceHighEmphasis)

                    Spacer()
                }
                .padding()
            }
        }
        .leadingBar {
            BarButton(type: .secondary("Settings", action: { isShowSetting.toggle() }))
        }
        .navigationable()
        .sheet(isPresented: $isShowSetting) {
            AppearanceSettingView()
        }
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
//            .navigationBar("Title", style: .fixed) {
//                BarButton(type: .back)
//            } trailingBar: {} bottomBar: {}

        .scrollWithNavigationBar("App", style: .fixed($offset), background: Color.backgroundSecondary) {
            BarButton(type: .back)
        } trailingBar: {} bottomBar: {}
    }
}

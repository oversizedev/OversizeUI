//
// Copyright © 2021 Alexander Romanov
// RadioPicker.swift, created on 07.02.2023
//

import SwiftUI

public struct RadioPicker<Element: Equatable, Content>: View where Content: View {
    public typealias Data = [Element]
    @State private var selectedIndex: Data.Index?
    @Binding private var selection: Data.Element
    private let data: Data
    private var defaultSelection: Bool
    private let alignment: RadioAlignment
    private let verticalAlignment: VerticalAlignment
    private let content: (Data.Element) -> Content

    public init(_ data: Data,
                selection: Binding<Data.Element>,
                defaultSelection: Bool = true,
                alignment: RadioAlignment = .trailing,
                verticalAlignment: VerticalAlignment = .center,
                @ViewBuilder content: @escaping (Data.Element) -> Content)
    {
        self.data = data
        _selection = selection
        self.defaultSelection = defaultSelection
        self.alignment = alignment
        self.verticalAlignment = verticalAlignment
        self.content = content
    }

    public var body: some View {
        VStack(spacing: 24) {
            ForEach(data.indices, id: \.self) { index in
                Radio(isOn: selectedIndex == index, alignment: alignment, verticalAlignment: verticalAlignment) {
                    selectedIndex = index
                    selection = data[index]
                } label: {
                    content(data[index])
                }
                .onChange(of: selection) { value in
                    if value == data[index] {
                        selectedIndex = index
                    }
                }
            }
            .onAppear {
                if defaultSelection {
                    selectedIndex = 0
                }
            }
        }
    }
}

/*
 struct RadioPicker_LibraryContent: LibraryContentProvider {
     var views: [LibraryItem] {
         LibraryItem(
             RadioPicker(["One", "Two"], selection: .constant("One")) { item in
                 Text(item)
             },
             title: "Radio Picker", category: .control
         )
     }
 }
 */

struct RadioPicker_previw: PreviewProvider {
    struct RadioPickerPreview: View {
        var data = ["One", "Two", "Three", "Four"]
        @State var selection = ""
        var body: some View {
            VStack {
                RadioPicker(data, selection: $selection) { item in
                    Text(item)
                }
                .onChange(of: selection) { selectedItem in
                    print(selectedItem)
                }
            }
            .padding()
            .background(Color.backgroundSecondary)
        }
    }

    static var previews: some View {
        Group {
            RadioPickerPreview()
                .previewDisplayName("Radio buttons (Light theme)")
            RadioPickerPreview()
                .previewDisplayName("Radio buttons (Dark theme)")
                .colorScheme(.dark)
        }

        .previewLayout(.sizeThatFits)
    }
}

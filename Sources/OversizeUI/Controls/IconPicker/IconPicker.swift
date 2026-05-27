//
// Copyright © 2021 Alexander Romanov
// IconPicker.swift, created on 02.04.2022
//

import SwiftUI

public enum IconPickerStyle {
    case field, circle
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct IconPicker: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    private let icons: [Image]
    @Binding private var selectedIndex: Int?

    private var gridPadding: CGFloat {
        guard let sizeClass = horizontalSizeClass else { return 40 }
        switch sizeClass {
        case .compact:
            return 60
        default:
            return 72
        }
    }

    public init(icons: [Image], selectedIndex: Binding<Int?>) {
        self.icons = icons
        _selectedIndex = selectedIndex
    }

    public var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: gridPadding))]) {
            ForEach(icons.indices, id: \.self) { index in
                Button(
                    action: { selectedIndex = index },
                    label: {
                        Group {
                            icons[index]
                                .resizable()
                                .frame(width: 24, height: 24, alignment: .center)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: .xxxSmall, style: .continuous)
                                .strokeBorder(
                                    selectedIndex == index ? Color.accentColor : Color.border,
                                    lineWidth: selectedIndex == index ? 2 : 1
                                )
                                .frame(width: 48, height: 48, alignment: .center)
                        )
                        .padding(.vertical, horizontalSizeClass == .compact ? 12 : 20)
                    }
                )
            }
        }
        .padding(.top, .medium)
        .paddingContent(.horizontal)
        .paddingContent(.bottom)
    }
}

//
// Copyright © 2021 Alexander Romanov
// IconPicker.swift, created on 02.04.2022
//

import SwiftUI

#if os(iOS)
    public struct IconPicker: View {
        @Environment(\.theme) private var theme: ThemeSettings
        @Environment(\.horizontalSizeClass) var horizontalSizeClass

        private let label: String
        private let icons: [Image]
        @Binding private var selection: Image?
        @State private var showModal = false
        @State private var isSelected = false

        @State private var selectedIndex: Int?

        @State var offset = CGPoint(x: 0, y: 0)

        private var gridPadding: CGFloat {
            guard let sizeClass = horizontalSizeClass else { return 40 }
            switch sizeClass {
            case .compact:
                return 60
            default:
                return 72
            }
        }

        public init(_ label: String,
                    _ icons: [Image],
                    selection: Binding<Image?>)
        {
            self.label = label
            self.icons = icons
            _selection = selection
        }

        public var body: some View {
            Button {
                self.showModal.toggle()
            } label: {
                HStack(spacing: .xxSmall) {
                    Text(label)
                        .headline()
                        .foregroundOnSurfaceHighEmphasis()
                }
                Spacer()
                if let image = selection {
                    image
                }
                Icon(.chevronDown, color: .onSurfaceHighEmphasis)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Radius.medium,
                                 style: .continuous)
                    .fill(Color.surfaceSecondary)
                    .overlay(
                        RoundedRectangle(cornerRadius: Radius.medium,
                                         style: .continuous)
                            .stroke(theme.borderTextFields
                                ? Color.border
                                : Color.surfaceSecondary, lineWidth: CGFloat(theme.borderSize))
                    )
            )
            .sheet(isPresented: $showModal) {
                modal
            }
        }

        private var modal: some View {
            PageView(label) {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: gridPadding))]) {
                        ForEach(icons.indices, id: \.self) { index in
                            Button(action: {
                                       selectedIndex = index

                                   },
                                   label: {
                                       if index == selectedIndex {
                                           Group {
                                               icons[index]
                                                   .resizable()

                                                   .frame(width: 24, height: 24, alignment: .center)
                                           }
                                           .overlay(
                                               RoundedRectangle(cornerRadius: Radius.medium, style: .continuous)
                                                   .strokeBorder(Color.border, lineWidth: 1)
                                                   .frame(width: 48, height: 48, alignment: .center)
                                           )

                                       } else {
                                           icons[index]
                                               .resizable()
                                               .frame(width: 24, height: 24, alignment: .center)
                                       }
                                   })
                                   .padding(.vertical, horizontalSizeClass == .compact ? 12 : 20)
                        }
                    }
                    .padding(.top, .medium)
                    .paddingContent(.horizontal)
                    .paddingContent(.bottom)
                }
            }
            .leadingBar {
                BarButton(type: .close)
            }
            .trailingBar {
                BarButton(type: .secondary("Save", action: {
                    selection = icons[selectedIndex ?? 0]
                    isSelected = true
                    showModal.toggle()
                }))
            }
        }
    }
#endif

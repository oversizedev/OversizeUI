//
// Copyright © 2021 Alexander Romanov
// Created on 24.09.2021
//

import SwiftUI

public struct SegmentedPickerSelector<Element: Equatable, Content, Selection>: View
    where
    Content: View,
    Selection: View
{
    @ObservedObject var appearanceSettings = AppearanceSettings.shared

    @Environment(\.segmentedControlStyle) private var style
    public typealias Data = [Element]

    @State private var frames: [CGRect]
    @State private var selectedIndex: Data.Index? = 0
    private let radius: Radius
    @Binding private var selection: Data.Element

    private let data: Data
    private let selectionView: () -> Selection?
    private let content: (Data.Element, Bool) -> Content
    private let action: (() -> Void)?

    public init(_ data: Data,
                selection: Binding<Data.Element>,
                radius: Radius = .medium,
                @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
                @ViewBuilder selectionView: @escaping () -> Selection? = { nil },
                action: (() -> Void)? = nil)
    {
        self.data = data
        self.content = content
        self.radius = radius
        self.selectionView = selectionView
        self.action = action
        _selection = selection
        _frames = State(wrappedValue: Array(repeating: .zero,
                                            count: data.count))
    }

    public var body: some View {
        style
            .makeBody(
                configuration: SegmentedControlConfiguration(
                    label: SegmentedControlConfiguration.Label(content: getSegmentedControl()
                    )
                )
            )
            .clipBackground(style.isShowBackground, radius: radius.rawValue)
            .onAppear {
                let selctedValue = self.selection
                var index = 0
                for dataValue in data {
                    if selctedValue == dataValue {
                        selectedIndex = index
                    }
                    index += 1
                }
            }
    }

    @ViewBuilder
    private func getSegmentedControl() -> some View {
        switch style.isEquallySpacing {
        case true:
            equallSegmentedControl
        case false:
            leadingSegmentedControl
        }
    }

    private var equallSegmentedControl: some View {
        ZStack(alignment: Alignment(horizontal: .horizontalCenterAlignment,
                                    vertical: .center)) {
            if let selectedIndex = selectedIndex {
                HStack(spacing: 0) {
                    Spacer()
                    selectionView()
                    Spacer()
                }
                .frame(width: frames[selectedIndex].width,
                       height: frames[selectedIndex].height)
                .alignmentGuide(.horizontalCenterAlignment) { dimensions in
                    dimensions[HorizontalAlignment.center]
                }
                .background(getSelection(selectionStyle: style.seletionStyle))
            }

            HStack(spacing: 0) {
                ForEach(data.indices, id: \.self) { index in
                    Button(action: {
                               selectedIndex = index
                               selection = data[index]
                               (action)?()
                           },
                           label: {
                               HStack(spacing: 0) {
                                   Spacer()

                                   content(data[index],
                                           selectedIndex == index)
                                       .fontStyle(.button,
                                                  color: .onSurfaceHighEmphasis)
                                       .multilineTextAlignment(.center)
                                   Spacer()
                               }

                               .padding(.vertical, .xxSmall)
                               // .padding(.horizontal, .xxxSmall)
                               .background(selectedIndex != index
                                   ? getUnselection(unselectionStyle: style.unseletionStyle)
                                   : nil)
                           })

                        .buttonStyle(PlainButtonStyle())
                        .background(GeometryReader { proxy in
                            Color.clear.onAppear { frames[index] = proxy.frame(in: .global) }
                        })
                        .alignmentGuide(.horizontalCenterAlignment,
                                        isActive: selectedIndex == index) { dimensions in
                            dimensions[HorizontalAlignment.center]
                        }
                        .padding(.trailing, style.unseletionStyle == .surface ? Space.xSmall.rawValue : 0)
                }
            }
        }
        // .animation(.easeInOut(duration: 0.3))
    }

    private var leadingSegmentedControl: some View {
        ZStack(alignment: Alignment(horizontal: .horizontalCenterAlignment,
                                    vertical: .center)) {
            if let selectedIndex = selectedIndex {
                HStack {
                    selectionView()
                }

                .frame(width: frames[selectedIndex].width,
                       height: frames[selectedIndex].height)
                .alignmentGuide(.horizontalCenterAlignment) { dimensions in
                    dimensions[HorizontalAlignment.center]
                }
                .background(getSelection(selectionStyle: style.seletionStyle))
            }

            HStack(spacing: 0) {
                ForEach(data.indices, id: \.self) { index in
                    Button(action: {
                               selectedIndex = index
                               selection = data[index]
                               (action)?()
                           },
                           label: { content(data[index], selectedIndex == index)
                               .fontStyle(.button,
                                          color: .onSurfaceHighEmphasis)

                               .multilineTextAlignment(.center)
                               .padding(.vertical, .xxSmall)
                               .padding(.horizontal, .small)
                               .background(selectedIndex != index
                                   ? getUnselection(unselectionStyle: style.unseletionStyle)
                                   : nil)
                           })
                        .buttonStyle(PlainButtonStyle())
                        .background(GeometryReader { proxy in
                            Color.clear.onAppear { frames[index] = proxy.frame(in: .global) }
                        })
                        .alignmentGuide(.horizontalCenterAlignment,
                                        isActive: selectedIndex == index) { dimensions in
                            dimensions[HorizontalAlignment.center]
                        }
                        .padding(.trailing, style.unseletionStyle == .surface ? Space.xSmall.rawValue : 0)
                }
            }
        }
    }

    @ViewBuilder
    private func getSelection(selectionStyle: SegmentedControlSeletionStyle) -> some View {
        switch selectionStyle {
        case .shadowSurface:

            RoundedRectangle(cornerRadius: style.isShowBackground ? radius.rawValue - 4 : radius.rawValue,
                             style: .continuous)
                .fill(Color.surfacePrimary)
                .overlay(
                    RoundedRectangle(cornerRadius: style.isShowBackground ? radius.rawValue - 4 : radius.rawValue,
                                     style: .continuous)
                        .stroke(appearanceSettings.borderControls
                            ? Color.border
                            : Color.surfaceSecondary, lineWidth: CGFloat(appearanceSettings.borderSize))
                )
                .shadowElevaton(.z2)
        case .graySurface:

            if style.unseletionStyle == .clean {
                RoundedRectangle(cornerRadius: radius.rawValue,
                                 style: .continuous)
                    .fill(Color.surfaceSecondary)
                    .overlay(
                        RoundedRectangle(cornerRadius: radius.rawValue,
                                         style: .continuous)
                            .stroke(appearanceSettings.borderControls
                                ? Color.border
                                : Color.surfaceSecondary, lineWidth: CGFloat(appearanceSettings.borderSize))
                    )

            } else {
                RoundedRectangle(cornerRadius: style.isShowBackground ? radius.rawValue - 4 : radius.rawValue,
                                 style: .continuous)
                    .strokeBorder(Color.onSurfaceMediumEmphasis, lineWidth: 2)
            }
        case .accentSurface:
            RoundedRectangle(cornerRadius: style.isShowBackground ? radius.rawValue - 4 : radius.rawValue,
                             style: .continuous)
                .strokeBorder(Color.blue, lineWidth: 2)
        }
    }

    @ViewBuilder
    private func getUnselection(unselectionStyle: SegmentedControlUnseletionStyle) -> some View {
        switch unselectionStyle {
        case .clean:
            EmptyView()
        case .surface:

            RoundedRectangle(cornerRadius: radius.rawValue,
                             style: .continuous)
                .fill(Color.surfaceSecondary)
                .overlay(
                    RoundedRectangle(cornerRadius: radius.rawValue,
                                     style: .continuous)
                        .stroke(appearanceSettings.borderControls
                            ? Color.border
                            : Color.surfaceSecondary, lineWidth: CGFloat(appearanceSettings.borderSize))
                )
        }
    }
}

public extension SegmentedPickerSelector where Selection == EmptyView {
    init(_ data: Data,
         selection: Binding<Data.Element>,
         radius: Radius = .medium,
         @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
         action: (() -> Void)? = nil)
    {
        self.data = data
        self.content = content
        self.radius = radius
        self.action = action
        selectionView = { nil }
        _selection = selection
        _frames = State(wrappedValue: Array(repeating: .zero,
                                            count: data.count))
    }
}

private extension View {
    @ViewBuilder
    func clipBackground(_ isClip: Bool, radius: CGFloat) -> some View {
        switch isClip {
        case true:
            cornerRadius(radius)
        case false:
            self
        }
    }
}

// swiftlint:disable all
struct SegmentedPicker_Preview: PreviewProvider {
    static var previews: some View {
        SegmentedControlPreview()
    }
}

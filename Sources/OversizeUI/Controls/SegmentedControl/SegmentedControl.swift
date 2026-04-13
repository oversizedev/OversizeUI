//
// Copyright © 2021 Alexander Romanov
// SegmentedControl.swift, created on 12.08.2021
//

import SwiftUI

public struct SegmentedPickerSelector<Element: Equatable, Content: View, Selection: View>: View {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.segmentedControlStyle) private var style
    @Environment(\.controlRadius) var controlRadius
    @Environment(\.segmentedPickerMargins) var controlPadding: EdgeInsets
    @Environment(\.platform) var platform: Platform

    public typealias Data = [Element]

    @State private var frames: [CGRect]
    @State private var selectedIndex: Data.Index? = 0
    @Binding private var selection: Data.Element

    private let data: Data
    private let selectionView: () -> Selection?
    private let content: (Data.Element, Bool) -> Content
    private let action: (() -> Void)?

    public init(
        _ data: Data,
        selection: Binding<Data.Element>,
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        @ViewBuilder selectionView: @escaping () -> Selection? = { nil },
        action: (() -> Void)? = nil
    ) {
        self.data = data
        self.content = content
        self.selectionView = selectionView
        self.action = action
        _selection = selection
        _frames = State(wrappedValue: Array(
            repeating: .zero,
            count: data.count
        ))
    }

    public var body: some View {
        style
            .makeBody(
                configuration: SegmentedControlConfiguration(
                    label: SegmentedControlConfiguration.Label(content: getSegmentedControl())
                )
            )
            .clipBackground(style.isShowBackground, radius: controlRadius)
            .onAppear {
                let selctedValue = selection
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
        ZStack(alignment: Alignment(
            horizontal: .horizontalCenterAlignment,
            vertical: .center
        )) {
            if let selectedIndex {
                HStack(spacing: 0) {
                    selectionView()
                        .contentShape(Rectangle())
                        .frame(
                            maxWidth: .infinity,
                            alignment: .center
                        )
                }
                .frame(
                    width: frames[selectedIndex].width,
                    height: frames[selectedIndex].height,
                    alignment: .center
                )
                .alignmentGuide(.horizontalCenterAlignment) { dimensions in
                    dimensions[HorizontalAlignment.center]
                }
                .background(getSelection(selectionStyle: style.seletionStyle))
            }

            HStack(spacing: 0) {
                ForEach(data.indices, id: \.self) { index in
                    Button(
                        action: {
                            selectedIndex = index
                            selection = data[index]
                            action?()
                        },
                        label: {
                            HStack(spacing: 0) {
                                content(
                                    data[index],
                                    selectedIndex == index
                                )
                                .body(.semibold)
                                .foregroundColor(style.seletionStyle == .accentSurface && selectedIndex == index ? Color.onPrimary : Color.onSurfacePrimary)
                                .multilineTextAlignment(.center)
                                .contentShape(Rectangle())
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .center
                                )
                            }
                            .padding(.leading, controlPadding.leading)
                            .padding(.trailing, controlPadding.trailing)
                            .padding(
                                .top,
                                controlPadding.top != 0 || controlPadding.top != .xxSmall
                                    ? controlPadding.top - .xxSmall
                                    : 0
                            )
                            .padding(
                                .bottom,
                                controlPadding.bottom != 0 || controlPadding.bottom != .xxSmall
                                    ? controlPadding.bottom - .xxSmall
                                    : 0
                            )
                            .background(selectedIndex != index
                                ? getUnselection(unselectionStyle: style.unseletionStyle)
                                : nil)
                        }
                    )

                    .buttonStyle(PlainButtonStyle())
                    .background(GeometryReader { proxy in
                        Color.clear.onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { frames[index] = proxy.frame(in: .global) } }
                    })
                    .alignmentGuide(
                        .horizontalCenterAlignment,
                        isActive: selectedIndex == index
                    ) { dimensions in
                        dimensions[HorizontalAlignment.center]
                    }
                    .padding(.trailing, style.unseletionStyle == .surface ? .xSmall : 0)
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: selection)
    }

    private var leadingSegmentedControl: some View {
        ZStack(alignment: Alignment(
            horizontal: .horizontalCenterAlignment,
            vertical: .center
        )) {
            if let selectedIndex {
                HStack {
                    selectionView()
                        .contentShape(Rectangle())
                }
                .frame(
                    width: frames[selectedIndex].width,
                    height: frames[selectedIndex].height
                )
                .alignmentGuide(.horizontalCenterAlignment) { dimensions in
                    dimensions[HorizontalAlignment.center]
                }
                .background(getSelection(selectionStyle: style.seletionStyle))
            }

            HStack(spacing: 0) {
                ForEach(data.indices, id: \.self) { index in
                    Button(
                        action: {
                            selectedIndex = index
                            selection = data[index]
                            action?()
                        },
                        label: { content(data[index], selectedIndex == index)
                            .body(.semibold)
                            .foregroundColor(style.seletionStyle == .accentSurface && selectedIndex == index ? Color.onPrimary : Color.onSurfacePrimary)
                            .multilineTextAlignment(.center)
                            .padding(.leading, controlPadding.leading)
                            .padding(.trailing, controlPadding.trailing)
                            .padding(
                                .top,
                                controlPadding.top != 0 || controlPadding.top != .xxSmall
                                    ? controlPadding.top - .xxSmall
                                    : 0
                            )
                            .padding(
                                .bottom,
                                controlPadding.bottom != 0 || controlPadding.bottom != .xxSmall
                                    ? controlPadding.bottom - .xxSmall
                                    : 0
                            )
                            .background(selectedIndex != index
                                ? getUnselection(unselectionStyle: style.unseletionStyle)
                                : nil)
                        }
                    )
                    .buttonStyle(PlainButtonStyle())
                    .background(GeometryReader { proxy in
                        Color.clear.onAppear { frames[index] = proxy.frame(in: .global) }
                    })
                    .alignmentGuide(
                        .horizontalCenterAlignment,
                        isActive: selectedIndex == index
                    ) { dimensions in
                        dimensions[HorizontalAlignment.center]
                    }
                    .padding(.trailing, style.unseletionStyle == .surface ? .xSmall : 0)
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: selection)
    }

    @ViewBuilder
    private func getSelection(selectionStyle: SegmentedControlSeletionStyle) -> some View {
        switch selectionStyle {
        case .shadowSurface:
            RoundedRectangle(
                cornerRadius: style.isShowBackground ? controlRadius - 4 : controlRadius,
                style: .continuous
            )
            .fill(Color.surfacePrimary)
            .overlay(
                RoundedRectangle(
                    cornerRadius: style.isShowBackground
                        ? controlRadius - 4
                        : controlRadius,
                    style: .continuous
                )
                .stroke(
                    theme.borderControls
                        ? Color.border
                        : Color.surfaceSecondary,
                    lineWidth: CGFloat(theme.borderSize)
                )
            )
            .shadowElevation(platform == .macOS ? .z0 : .z2)

        case .graySurface:
            if style.unseletionStyle == .clean {
                RoundedRectangle(
                    cornerRadius: controlRadius,
                    style: .continuous
                )
                .fill(Color.surfaceSecondary)
                .overlay(
                    RoundedRectangle(
                        cornerRadius: controlRadius,
                        style: .continuous
                    )
                    .stroke(
                        theme.borderControls
                            ? Color.border
                            : Color.surfaceSecondary,
                        lineWidth: CGFloat(theme.borderSize)
                    )
                )

            } else {
                RoundedRectangle(
                    cornerRadius: style.isShowBackground
                        ? controlRadius - 4
                        : controlRadius,
                    style: .continuous
                )
                .strokeBorder(Color.onSurfaceSecondary, lineWidth: 2)
            }

        case .accentSurface:
            RoundedRectangle(
                cornerRadius: style.isShowBackground ? controlRadius - 4 : controlRadius,
                style: .continuous
            )
            .fill(Color.accent)
        }
    }

    @ViewBuilder
    private func getUnselection(unselectionStyle: SegmentedControlUnseletionStyle) -> some View {
        switch unselectionStyle {
        case .clean:
            EmptyView()
        case .surface:
            RoundedRectangle(
                cornerRadius: controlRadius,
                style: .continuous
            )
            .fill(Color.surfaceSecondary)
            .overlay(
                RoundedRectangle(
                    cornerRadius: controlRadius,
                    style: .continuous
                )
                .stroke(
                    theme.borderControls
                        ? Color.border
                        : Color.surfaceSecondary,
                    lineWidth: CGFloat(theme.borderSize)
                )
            )
        }
    }
}

public extension SegmentedPickerSelector where Selection == EmptyView {
    init(
        _ data: Data,
        selection: Binding<Data.Element>,
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        action: (() -> Void)? = nil
    ) {
        self.data = data
        self.content = content
        self.action = action
        selectionView = { nil }
        _selection = selection
        _frames = State(wrappedValue: Array(
            repeating: .zero,
            count: data.count
        ))
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

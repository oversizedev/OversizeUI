//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public struct FontSettingView: View {
    public init() {}

    @ObservedObject private var theme = AppearanceSettings.shared

    @State private var activeTab: FontSetting = .title

    private enum FontSetting: String, CaseIterable {
        case title, paragraph, other
    }

    @State var offset = CGPoint(x: 0, y: 0)

    public var body: some View {
        VStack(spacing: 0) {
            previewText

            SegmentedPickerSelector(FontSetting.allCases, selection: $activeTab) { item, _ in
                Text(item.rawValue.capitalizingFirstLetter())
            } selectionView: {}

            getActiveTabContent(tab: activeTab)
                .padding(.top, .small)
        }
        .padding(.horizontal)
        .padding(.bottom)
        .navigationBar("Fonts", style: .fixed($offset)) {
            BarButton(type: .back)
        } trailingBar: {} bottomBar: {}
    }

    @ViewBuilder
    private func getActiveTabContent(tab: FontSetting) -> some View {
        switch tab {
        case .title:
            titleSelector
        case .paragraph:
            paragraphSelector
        case .other:
            otherSelector
        }
    }

    private var titleSelector: some View {
        GridSelect(FontDesignType.allCases, selection: $theme.fontTitle,
                   content: { fontStyle, _ in
                       HStack {
                           VStack(alignment: .leading, spacing: 8) {
                               Text("Aa")
                                   .font(.system(size: 34, weight: .heavy, design: fontStyle.system))
                                   .foregroundColor(.onSurfaceHighEmphasis)

                               Text(fontStyle.rawValue.capitalizingFirstLetter())
                                   .font(.system(size: 16, weight: .medium, design: fontStyle.system))
                                   .foregroundColor(.onSurfaceHighEmphasis)
                           }
                           Spacer()
                       }.padding()
                   }).gridSelectStyle(.default(selected: .graySurface))
    }

    private var paragraphSelector: some View {
        GridSelect(FontDesignType.allCases, selection: $theme.fontParagraph,
                   content: { fontStyle, _ in
                       HStack {
                           VStack(alignment: .leading, spacing: 8) {
                               Text("Aa")
                                   .font(.system(size: 34, weight: .heavy, design: fontStyle.system))
                                   .foregroundColor(.onSurfaceHighEmphasis)

                               Text(fontStyle.rawValue.capitalizingFirstLetter())
                                   .font(.system(size: 16, weight: .medium, design: fontStyle.system))
                                   .foregroundColor(.onSurfaceHighEmphasis)
                           }
                           Spacer()
                       }.padding()
                   }).gridSelectStyle(.default(selected: .graySurface))
    }

    private var otherSelector: some View {
        VStack(alignment: .leading, spacing: Space.medium.rawValue) {
            VStack(alignment: .leading, spacing: Space.small.rawValue) {
                Text("Button".uppercased())
                    .fontStyle(.overline, color: .onBackgroundMediumEmphasis)
                SegmentedPickerSelector(FontDesignType.allCases, selection: $theme.fontButton) { fontStyle, _ in
                    VStack(alignment: .center, spacing: 8) {
                        Text("Aa")
                            .font(.system(size: 28, weight: .heavy, design: fontStyle.system))
                            .foregroundColor(.onSurfaceHighEmphasis)

                        Text(fontStyle.rawValue.capitalizingFirstLetter())
                            .font(.system(size: 12, weight: .medium, design: fontStyle.system))
                            .foregroundColor(.onSurfaceHighEmphasis)
                    }
                }
                .segmentedControlStyle(.island(selected: .graySurface))
            }

            VStack(alignment: .leading, spacing: Space.small.rawValue) {
                Text("Overline & caption".uppercased())
                    .fontStyle(.overline, color: .onBackgroundMediumEmphasis)
                SegmentedPickerSelector(FontDesignType.allCases, selection: $theme.fontOverline) { fontStyle, _ in
                    VStack(alignment: .center, spacing: 8) {
                        Text("Aa")
                            .font(.system(size: 28, weight: .heavy, design: fontStyle.system))
                            .foregroundColor(.onSurfaceHighEmphasis)

                        Text(fontStyle.rawValue.capitalizingFirstLetter())
                            .font(.system(size: 12, weight: .medium, design: fontStyle.system))
                            .foregroundColor(.onSurfaceHighEmphasis)
                    }
                }
                .segmentedControlStyle(.island(selected: .graySurface))
            }
        }
    }
}

// swiftlint:disable all
extension FontSettingView {
    private var previewText: some View {
        ScrollViewOffset(offset: $offset) {
            HStack {
                VStack(alignment: .leading, spacing: Space.medium.rawValue) {
                    VStack(alignment: .leading, spacing: Space.xxSmall.rawValue) {
                        Text("Overline".uppercased())
                            .fontStyle(.overline, color: .onBackgroundMediumEmphasis)

                        Text("Large title")
                            .fontStyle(.largeTitle, color: .onBackgroundHighEmphasis)

                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                            .fontStyle(.paragraph1, color: .onBackgroundHighEmphasis)
                    }

                    VStack(alignment: .leading, spacing: Space.xxSmall.rawValue) {
                        Text("Title")
                            .fontStyle(.title3, color: .onBackgroundHighEmphasis)

                        Text("Subtitle")
                            .fontStyle(.subtitle1, color: .onBackgroundHighEmphasis)

                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                            .fontStyle(.paragraph2, color: .onBackgroundHighEmphasis)

                        Text("Button")
                            .fontStyle(.button, color: .onBackgroundHighEmphasis)
                            .padding(.top, .xxxSmall)
                    }
                }
                Spacer()
            }
            .padding(.vertical)
        }
    }
}

struct FontSettingView_Previews: PreviewProvider {
    static var previews: some View {
        FontSettingView()
    }
}

//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public struct BorderSettingView: View {
    public init() {}

    @ObservedObject var theme = AppearanceSettings.shared

    @State var offset = CGPoint(x: 0, y: 0)

    public var body: some View {
        settings
    }

    private var settings: some View {
        VStack(alignment: .center, spacing: 0) {
            SectionView {
                VStack(spacing: .zero) {
                    Toggle("Borders in app", isOn: $theme.borderApp)
                        .onChange(of: theme.borderApp) { value in
                            theme.borderSurface = value
                            theme.borderButtons = value
                            theme.borderControls = value
                            theme.borderTextFields = value
                        }
                        .fontStyle(.subtitle1)
                        .foregroundColor(.onSurfaceHighEmphasis)
                        .padding(.horizontal, .medium)
                        .padding(.vertical, .small)

                    if theme.borderApp {
                        VStack(spacing: Space.small.rawValue) {
                            #if os(iOS) || os(macOS)
                                VStack(spacing: Space.xxSmall.rawValue) {
                                    HStack {
                                        Text("Size")
                                            .fontStyle(.paragraph2)
                                            .foregroundColor(.onSurfaceHighEmphasis)

                                        Spacer()

                                        Text(String(format: "%.1f", theme.borderSize) + " px")
                                            .fontStyle(.subtitle2)
                                            .foregroundColor(.onSurfaceHighEmphasis)
                                    }

                                    Slider(value: $theme.borderSize, in: 0.5 ... 2, step: 0.5)

                                }.surface(background: .secondary, padding: .small)
                                    .padding(.horizontal, Space.medium)
                                    .padding(.bottom, Space.xxSmall)

                            #endif

                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.border)
                                .padding(.horizontal, theme.borderSurface ? 0 : Space.medium.rawValue)

                            VStack(spacing: .zero) {
                                Row("Surface",
                                    trallingType: .toggle(isOn: theme.$borderSurface),
                                    paddingVertical: .xSmall)
                                Row("Buttons",
                                    trallingType: .toggle(isOn: theme.$borderSurface),
                                    paddingVertical: .xSmall)
                                Row("Text fields",
                                    trallingType: .toggle(isOn: theme.$borderSurface),
                                    paddingVertical: .xSmall)
                                Row("Other controls",
                                    trallingType: .toggle(isOn: theme.$borderSurface),
                                    paddingVertical: .xSmall)
                            }.padding(.top, .xxxSmall)
                                .padding(.vertical, .xxxSmall)
                        }
                    }
                }
            }

            Spacer()
        }

        .navigationBar("Border", style: .fixed($offset)) {
            BarButton(type: .back)
        } trailingBar: {} bottomBar: {}

        .background(Color.backgroundSecondary.ignoresSafeArea(.all))
        .preferredColorScheme(theme.appearance.colorScheme)
        .animation(.easeIn(duration: 0.2))
    }
}

struct BorderSettongView_Previews: PreviewProvider {
    static var previews: some View {
        BorderSettingView()
            .previewPhones()
    }
}

//
// Copyright © 2021 Alexander Romanov
// Created on 12.09.2021
//

import SwiftUI

struct RadiusSettingView: View {
    @StateObject var theme = AppearanceSettings.shared

    @State var offset = CGPoint(x: 0, y: 0)

    public var body: some View {
        settings
    }

    private var settings: some View {
        VStack(alignment: .center, spacing: 0) {
            SectionView {
                VStack(spacing: .zero) {
                    VStack(spacing: Space.small.rawValue) {
                        #if os(iOS) || os(macOS)
                            VStack(spacing: Space.xxSmall.rawValue) {
                                HStack {
                                    Text("Size")
                                        .fontStyle(.paragraph2)
                                        .foregroundColor(.onSurfaceHighEmphasis)

                                    Spacer()

                                    Text(String(format: "%.0f", theme.radius) + "  px")
                                        .fontStyle(.subtitle2)
                                        .foregroundColor(.onSurfaceHighEmphasis)
                                }

                                Slider(value: $theme.radius, in: 0 ... 12, step: 4)
                            }
                            .padding(.horizontal, Space.medium)
                            .padding(.bottom, Space.xxSmall)

                        #endif
                    }
                }
            }

            Spacer()
        }

        .navigationBar("Radius", style: .fixed($offset)) {
            BarButton(type: .back)
        } trailingBar: {} bottomBar: {}

        .background(Color.backgroundSecondary.ignoresSafeArea(.all))
        .preferredColorScheme(theme.appearance.colorScheme)
        .animation(.easeIn(duration: 0.2))
    }
}

struct RadiusSettingView_Previews: PreviewProvider {
    static var previews: some View {
        RadiusSettingView()
    }
}

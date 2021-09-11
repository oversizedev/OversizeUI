//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public struct AppearanceSettingView: View {
    public init() {}

    @ObservedObject var theme = AppearanceSettings.shared

    #if os(iOS)
        @ObservedObject var iconSettings = AppIconSettings()
    #endif

    // swiftlint:disable trailing_comma
    private let columns = [
        GridItem(.adaptive(minimum: 78)),
    ]

    @State var offset = CGPoint(x: 0, y: 0)

    public var body: some View {
        #if os(iOS)
            iOSSettings
        #else
            macSettings
        #endif
    }

    #if os(iOS)
        private var iOSSettings: some View {
            VStack(alignment: .center, spacing: 0) {
                apperance

                accentColor

                advanded

                if iconSettings.iconNames.count > 1 {
                    appIcon
                }
            }

            .scrollWithNavigationBar("App", style: .fixed($offset), background: Color.backgroundSecondary) {
                BarButton(type: .close)
            } trailingBar: {} bottomBar: {}
            .background(Color.backgroundSecondary.ignoresSafeArea(.all))
            .preferredColorScheme(theme.appearance.colorScheme)
            .accentColor(theme.accentColor)
        }
    #endif

    private var macSettings: some View {
        VStack(alignment: .center, spacing: 0) {
            advanded
        }
        .frame(width: 400, height: 300)
        // swiftlint:disable multiple_closures_with_trailing_closure superfluous_disable_command

        .navigationTitle("Appearance")

        .preferredColorScheme(theme.appearance.colorScheme)
    }

    #if os(iOS)
        private var apperance: some View {
            SectionView {
                HStack {
                    ForEach(Appearance.allCases, id: \.self) { appearance in

                        HStack {
                            Spacer()

                            VStack(spacing: .zero) {
                                Text(appearance.name)
                                    .foregroundColor(.onSurfaceHighEmphasis)
                                    .font(.subheadline)
                                    .bold()

                                appearance.image
                                    .padding(.vertical, .medium)

                                if appearance == theme.appearance {
                                    Icon(.checkCircle, color: Color.accent)
                                } else {
                                    Icon(.circle, color: .onSurfaceMediumEmphasis)
                                }
                            }
                            Spacer()
                        }
                        .onTapGesture {
                            theme.appearance = appearance
                        }
                    }
                }.padding(.vertical, .xSmall)
            }
        }
    #endif

    #if os(iOS)
        private var accentColor: some View {
            SectionView("Accent color") {
                ColorSelector(selection: $theme.accentColor)
            }
        }

    #endif

    #if os(iOS)
        private var appIcon: some View {
            SectionView("App icon") {
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(0 ..< iconSettings.iconNames.count) { index in
                        HStack {
                            Image(uiImage: UIImage(named: iconSettings.iconNames[index]
                                    ?? "DefaultAppIcon") ?? UIImage())
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 78, height: 78)
                                .cornerRadius(18)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.accent,
                                                lineWidth: index == iconSettings.currentIndex ? 3 : 0)
                                )
                                .onTapGesture {
                                    let defaultIconIndex = self.iconSettings.iconNames
                                        .firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                                    if defaultIconIndex != index {
                                        // swiftlint:disable line_length
                                        UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[index]) { error in
                                            if let error = error {
                                                print(error.localizedDescription)
                                            } else {
                                                print("Success! You have changed the app icon.")
                                            }
                                        }
                                    }
                                }
                        }
                        .padding(3)
                    }
                }
                .padding()
            }
        }
    #endif

    private var advanded: some View {
        SectionView("Advanced settings") {
            VStack(spacing: .zero) {
                NavigationLink(destination: FontSettingView()) {
                    Row("Fonts", leadingType: .icon(.type))
                }

                NavigationLink(destination: BorderSettingView()) {
                    Row("Borders", leadingType: .icon(.layout))
                }
            }
        }
    }
}

struct SettingsThemeView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceSettingView()
            .previewPhones()
    }
}

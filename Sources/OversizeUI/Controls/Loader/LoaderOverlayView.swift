//
// Copyright © 2021 Alexander Romanov
// LoaderOverlayView.swift, created on 28.03.2021
//

import SwiftUI

public enum LoaderOverlayType {
    case image(image: Image)
    case spiner
}

public struct LoaderOverlayView: View {
    private var loaderType: LoaderOverlayType
    private let showText: Bool
    private let text: String
    private let surface: Bool

    @Binding var isLoading: Bool

    @State private var jump = false
    @State private var rotationImage = false

    public init(_ type: LoaderOverlayType = .spiner, isLoading: Binding<Bool> = .constant(true)) {
        loaderType = type
        showText = false
        text = ""
        surface = false
        _isLoading = isLoading
    }

    public init(type: LoaderOverlayType = .spiner,
                showText: Bool = false,
                text: String = "",
                surface: Bool = false,
                isLoading: Binding<Bool> = .constant(true))
    {
        loaderType = type
        self.showText = showText
        self.text = text
        self.surface = surface
        _isLoading = isLoading
    }

    public var body: some View {
        ZStack {
            #if os(iOS)
                BlurView()
            #else
                Color.surfaceSecondary.opacity(0.5)
            #endif

            VStack {
                Spacer()

                if surface {
                    Surface {
                        VStack(spacing: 20) {
                            containedView()

                            if showText {
                                Text(text.isEmpty ? "Loading" : text)
                                    .headline(.semibold)
                                    .foregroundOnSurfaceDisabled()
                                    .offset(y: 8)
                            }
                        }
                        .padding()
                    }
                    .surfaceStyle(.primary)
                    .elevation(.z4)
                } else {
                    VStack(spacing: 20) {
                        containedView()

                        if showText {
                            Text(text.isEmpty ? "Loading" : text)
                                .headline(.semibold)
                                .foregroundOnSurfaceDisabled()
                                .offset(y: 8)
                        }
                    }
                    .padding()
                    .background {
                        Capsule()
                            .fillSurfaceSecondary()
                    }
                }

                Spacer()
            }
        }
        .ignoresSafeArea()
        .opacity(isLoading ? 1 : 0)
    }

    @ViewBuilder
    private func containedView() -> some View {
        switch loaderType {
        case let .image(image: image):

            ZStack {
                //                    Circle()
                //                        .fill(Color.onSurfaceDisabled)
                //                        .frame(width: 40, height: 40)
                //                        .rotation3DEffect(
                //                            .init(degrees: 60),
                //                            axis: (x: 1, y: 0, z: 0.0),
                //                            anchor: .center,
                //                            anchorZ: 0.0,
                //                            perspective: 1.0
                //
                //                            )
                //                        .offset(y: 35)
                //                        .opacity(jump ? 1 : 0)

                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 96, height: 96, alignment: .center)
                    .rotationEffect(.init(degrees: rotationImage /* && jump */ ? 360 : 0))
                    .offset(y: jump ? -20 : 0)
                    .onAppear {
                        animate()
                    }
            }

        case .spiner:

            ProgressView()
        }
    }

    func animate() {
        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
            jump.toggle()
        }
        withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
            rotationImage.toggle()
        }
    }
}

struct LoaderOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            LoaderOverlayView(type: .image(ima), showText: true, text: "Download")
//
//            LoaderOverlayView(type: .image(image: "PinWallet"), showText: true)
//
//            LoaderOverlayView(type: .image(image: "PinWallet"))

            VStack {
                ScrollView {
                    Text("d")
                }
                .loading(true)
            }
        }
    }
}

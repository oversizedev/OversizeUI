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
    private let isShowBackground: Bool

    @Binding var isLoading: Bool
    

    @State private var jump = false
    @State private var rotationImage = false

    public init(_ type: LoaderOverlayType = .spiner, isLoading: Binding<Bool> = .constant(true)) {
        loaderType = type
        showText = false
        text = ""
        surface = false
        isShowBackground = true
        _isLoading = isLoading
    }

    public init(type: LoaderOverlayType = .spiner,
                showText: Bool = false,
                text: String = "",
                surface: Bool = false,
                isShowBackground: Bool = true,
                isLoading: Binding<Bool> = .constant(true))
    {
        loaderType = type
        self.showText = showText
        self.text = text
        self.surface = surface
        self.isShowBackground = isShowBackground
        _isLoading = isLoading
    }

    public var body: some View {


            VStack {
                Spacer()

                if surface {
                    Surface {
                        VStack(spacing: 20) {
                            containedView()

                            if showText {
                                Text(text.isEmpty ? "Loading" : text)
                                    .headline(.semibold)
                                    .onSurfaceDisabledForegroundColor()
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
                                .onSurfaceDisabledForegroundColor()
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
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            )
            .background(
                .ultraThinMaterial.opacity(isShowBackground ? 1 : 0),
                ignoresSafeAreaEdges: .all
            )
            .opacity(isLoading ? 1 : 0)
    }

    @ViewBuilder
    private func containedView() -> some View {
        switch loaderType {
        case let .image(image: image):

            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 96, height: 96, alignment: .center)
                .rotationEffect(.init(degrees: rotationImage /* && jump */ ? 360 : 0))
                .offset(y: jump ? -20 : 0)
                .onAppear {
                    animate()
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

public extension View {
    func loader(_ text: String? = nil, isPresented: Binding<Bool>) -> some View {
        self.overlay {
            LoaderOverlayView(text: text ?? "", isLoading: isPresented)
        }
    }
}

struct LoaderOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
        }
        .loader(isPresented: .constant(true))
    }
}

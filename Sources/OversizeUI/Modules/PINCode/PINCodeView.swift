//
// Copyright © 2022 Alexander Romanov
// PINCodeView.swift
//

import SwiftUI

public enum PINCodeViewState {
    case locked, loading, error, unlocked
}

public enum BiometricType: String {
    case none = ""
    case touchID = "Touch ID"
    case faceID = "Face ID"
}

public struct PINCodeView: View {
    @Binding private var pinCode: String

    @Binding private var state: PINCodeViewState

    @State private var shouldAnimate = false

    let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()

    @State var leftOffset: CGFloat = 0
    @State var rightOffset: CGFloat = 50

    private var maxCount: Int

    private var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)

    private let action: (() -> Void)?
    private let biometricAction: (() -> Void)?

    private let title: String?

    private let errorText: String?

    private let pinCodeEnabled: Bool
    private let biometricEnabled: Bool
    private let biometricType: BiometricType

    public init(pinCode: Binding<String>,
                state: Binding<PINCodeViewState> = .constant(.locked),
                maxCount: Int = 4,
                title: String? = nil,
                errorText: String? = nil,
                pinCodeEnabled: Bool = true,
                biometricEnabled: Bool = false,
                biometricType: BiometricType = .faceID,
                action: (() -> Void)? = nil,
                biometricAction: (() -> Void)? = nil)
    {
        _pinCode = pinCode
        _state = state
        self.maxCount = maxCount
        self.title = title
        self.errorText = errorText
        self.pinCodeEnabled = pinCodeEnabled
        self.biometricEnabled = biometricEnabled
        self.biometricType = biometricType
        self.action = action
        self.biometricAction = biometricAction
    }

    public var body: some View {
        content()
            .background(Color.surfacePrimary.ignoresSafeArea(.all))
    }

    @ViewBuilder
    func content() -> some View {
        switch pinCodeEnabled {
        case true:
            pinCodeView
        case false:
            biometricView
        }
    }

    var biometricView: some View {
        VStack {
            Spacer()

            Text(biometricType.rawValue)
                .fontStyle(.title2, color: .onBackgroundHighEmphasis)

            Spacer()

            biometricImage()
                .onTapGesture {
                    biometricAction?()
                }

            Spacer()
        }
    }

    var pinCodeView: some View {
        VStack {
            Spacer()

            Text(title ?? "")
                .fontStyle(.title2, color: .onBackgroundHighEmphasis)
                .opacity(title != nil ? 1 : 0)

            Spacer()

            pinCounter(state: state)

            Spacer()

            Text(errorText ?? "")
                .fontStyle(.subtitle2, color: .error)
                .opacity(state == .error ? 1 : 0)

            Spacer()

            numpad
        }
    }

    var numpad: some View {
        LazyVGrid(columns: gridItemLayout, spacing: 20) {
            ForEach(1 ... 9, id: \.self) { number in

                let stringNumber = String(number)

                Button {
                    appendNumber(number: Character(stringNumber))

                } label: {
                    Text(stringNumber)
                }
                .buttonStyle(NumpadButtonStyle())
                .disabled(state == .loading)
            }

            Button {} label: {
                Text("...")
            }.opacity(0)

            Button {
                appendNumber(number: Character("0"))
            } label: {
                Text("0")
            }
            .buttonStyle(NumpadButtonStyle())
            .disabled(state == .loading)

            Button {
                if pinCode.isEmpty, biometricEnabled {
                    biometricAction?()
                } else if pinCode.isEmpty, !biometricEnabled {
                } else {
                    deleteLastNumber()
                }
            } label: {
                if pinCode.isEmpty, biometricEnabled {
                    biometricImage()
                } else if pinCode.isEmpty, !biometricEnabled {
                    EmptyView()
                } else {
                    Icon(.delete)
                }
            } // .opacity(pinCode.isEmpty && biometricEnabled ? 1 : 0)
        }
        .paddingContent()
        .padding(.bottom, .xLarge)
    }

    @ViewBuilder
    private func biometricImage() -> some View {
        switch biometricType {
        case .none:
            EmptyView()
        case .touchID:
            Image(systemName: "touchid")
                .foregroundColor(Color.onBackgroundHighEmphasis)
                .font(.system(size: 32))
                .frame(width: 24, height: 24, alignment: .center)
        case .faceID:
            Image(systemName: "faceid")
                .font(.system(size: 32))
                .foregroundColor(Color.onBackgroundHighEmphasis)
                .frame(width: 24, height: 24, alignment: .center)
        }
    }

    @ViewBuilder
    private func pinCounter(state: PINCodeViewState) -> some View {
        switch state {
        case .locked, .error, .unlocked:
            HStack(spacing: .xSmall) {
                ForEach(0 ..< maxCount, id: \.self) { number in
                    Circle()
                        .fill(pinCode.count <= number ? Color.surfaceTertiary
                            : Color.accent)
                        .frame(width: 12, height: 12)
                }
            }
        case .loading:
            HStack(spacing: .xSmall) {
                ForEach(0 ..< maxCount, id: \.self) { number in
                    Circle()
                        .fill(pinCode.count <= number ? Color.surfaceTertiary
                            : Color.accent)
                        .frame(width: 12, height: 12)
                        .offset(x: leftOffset)
                        // .animation(Animation.easeInOut(duration: 1).delay(0.2 * Double(number)))

                        .scaleEffect(shouldAnimate ? 0.5 : 1)
                        .animation(Animation.easeInOut(duration: 0.5)
                            .repeatForever()
                            .delay(number == 0 ? 0 : 0.5 * Double(number)))
                }
            }
            .onReceive(timer) { _ in
                shouldAnimate.toggle()
            }
        }
    }

    func appendNumber(number: Character) {
        state = .locked

        if pinCode.count > (maxCount - 1) {
            print("return")
            return
        }

        if pinCode.count >= (maxCount - 1) {
            pinCode.append(number)
            enterAction()
        } else {
            pinCode.append(number)
        }
    }

    func deleteLastNumber() {
        state = .locked

        if pinCode.count <= maxCount {
            // isDisabledNumpad = false
        }
        pinCode.removeLast()
        print(pinCode)
    }

    func enterAction() {
        action?()
    }
}

public struct NumpadButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .fontStyle(.title2, color: .onSurfaceHighEmphasis)
            .frame(width: 72, height: 72, alignment: .center)
            .background(
                Circle()
                    .fill(configuration.isPressed ? Color.surfaceTertiary : Color.surfaceSecondary)
            )
    }
}

struct PINCodeView_Previews: PreviewProvider {
    static var previews: some View {
        PINCodeView(pinCode: .constant("123"), state: .constant(.locked))
    }
}

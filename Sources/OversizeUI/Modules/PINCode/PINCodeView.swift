//
// Copyright © 2021 Alexander Romanov
// Created on 31.10.2021
//

import SwiftUI

public enum PINCodeViewState {
    case `default`
    case loading
    case error
    case susses
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

    private let title: String?

    private let errorText: String?

    public init(pinCode: Binding<String>,
                state: Binding<PINCodeViewState> = .constant(.default),
                maxCount: Int = 4,
                title: String? = nil,
                errorText: String? = nil,
                action: (() -> Void)? = nil)
    {
        _pinCode = pinCode
        _state = state
        self.maxCount = maxCount
        self.title = title
        self.errorText = errorText
        self.action = action
    }

    public var body: some View {
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
        .background(Color.surfacePrimary.ignoresSafeArea(.all))
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
                deleteLastNumber()
            } label: {
                Icon(.delete)
            }.opacity(pinCode.isEmpty ? 0 : 1)
        }
        .paddingContent()
        .padding(.bottom, .xLarge)
    }

    @ViewBuilder
    private func pinCounter(state: PINCodeViewState) -> some View {
        switch state {
        case .default, .error, .susses:
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
        state = .default

        if pinCode.count > (maxCount - 1) {
            print("return")
            // isDisabledNumpad = true
            return
        }

        if pinCode.count >= (maxCount - 1) {
            pinCode.append(number)
            print(pinCode)
            enterAction()
            // isDisabledNumpad = true
        } else {
            pinCode.append(number)
            print(pinCode)
        }
    }

    func deleteLastNumber() {
        state = .default

        if pinCode.count <= maxCount {
            // isDisabledNumpad = false
        }
        pinCode.removeLast()
        print(pinCode)
    }

    func enterAction() {
        (action)?()
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
        PINCodeView(pinCode: .constant("123"), state: .constant(.default))
    }
}

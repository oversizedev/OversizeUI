//
// Copyright © 2021 Alexander Romanov
// SectionView.swift, created on 07.02.2023
//

import SwiftUI

public enum SectionViewTitlePosition: Sendable {
    case inside, outside
}

public enum SectionViewTitleButtonPosition: Sendable {
    case leading, trailing
}

public enum SectionViewTitleButton: Sendable {
    case arrow(_ action: @Sendable () -> Void)
    case title(_ title: String, _ action: @Sendable () -> Void)
}

public enum SectionViewStyle: Sendable {
    case `default`, smallIndent, edgeToEdge
}

public struct SectionView<Content: View>: View {
    @Environment(\.controlRadius) private var controlRadius: Radius
    @Environment(\.sectionViewStyle) private var style: SectionViewStyle
    @Environment(\.surfaceContentMargins) var surfaceContentInsets: EdgeSpaceInsets
    @Environment(\.sectionTitleMargins) var sectionTitleInsets: EdgeSpaceInsets
    #if os(iOS)
        @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    private let content: Content
    private let title: String

    private var titlePosition: SectionViewTitlePosition = .outside
    private var titleButton: SectionViewTitleButton?
    private var titleButtonPosition: SectionViewTitleButtonPosition = .trailing

    public init(_ title: String = "", @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    @available(*, deprecated, renamed: "surfaceContentInsets", message: "Set verticalPadding with .surfaceContentInsets")
    public init(_ title: String = "", verticalPadding _: Space = .xxSmall, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    private enum Constants {
        /// Radius
        static var radiusMedium: CGFloat { Radius.medium.rawValue }
        static var radiusSmall: CGFloat { Radius.small.rawValue }
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: Space.xSmall) {
            if !title.isEmpty, titlePosition == .outside {
                titleView
                    .padding(.horizontal, titleHorizontalPadding)
                    .padding(sectionTitleInsets)
                #if os(macOS)
                    .padding(.leading, .xxSmall)
                #endif
            }

            Surface {
                VStack(alignment: .leading, spacing: Space.xSmall) {
                    if !title.isEmpty, titlePosition == .inside {
                        titleView
                            .padding(sectionTitleInsets)
                    }
                    content
                }
            }
            .padding(.horizontal, surfaceHorizontalPadding)
        }
        .padding(.vertical, surfaceVerticalPaddingSize)
    }

    private var titleView: some View {
        HStack(spacing: titleButtonPosition == .leading ? .zero : .xxxSmall) {
            titleLabelView(titleButton)

            if titleButtonPosition == .trailing {
                Spacer()
            }

            if let titleButton {
                titleButtonView(titleButton)
            }

            if titleButtonPosition == .leading {
                Spacer()
            }
        }
    }

    private var titleFont: Font {
        switch titlePosition {
        case .inside:
            .title2.weight(.semibold)
        case .outside:
            .headline.weight(.semibold)
        }
    }

    private var titleColor: Color {
        switch titlePosition {
        case .inside:
            .onSurfacePrimary
        case .outside:
            .onBackgroundPrimary
        }
    }

    @ViewBuilder
    private func titleLabelView(_ button: SectionViewTitleButton?) -> some View {
        if let button {
            switch button {
            case let .arrow(action), let .title(_, action):
                Button {
                    action()
                } label: {
                    Text(title)
                        .font(titleFont)
                        .foregroundColor(titleColor)
                }
                .buttonStyle(.scale)
            }
        } else {
            Text(title)
                .font(titleFont)
                .foregroundColor(titleColor)
        }
    }

    @ViewBuilder
    private func titleButtonView(_ button: SectionViewTitleButton) -> some View {
        switch button {
        case let .arrow(action):
            Button {
                action()
            } label: {
                IconDeprecated(.chevronRight)
                    .iconColor(.onSurfaceSecondary)
                    .offset(y: titleButtonPosition == .leading ? 1.5 : 0)
            }
            .buttonStyle(.scale)
        case let .title(text, action):
            #if os(tvOS)
                Button(text) { action() }
                    .buttonStyle(.tertiary)
                    .controlBorderShape(.capsule)
            #else
                Button(text) { action() }
                    .buttonStyle(.tertiary)
                    .controlSize(.small)
                    .controlBorderShape(.capsule)
            #endif
        }
    }

    private var titleHorizontalPadding: CGFloat {
        #if os(iOS)
            if horizontalSizeClass == .regular {
                return Space.medium.rawValue + Space.large.rawValue
            } else {
                return Space.medium.rawValue
            }
        #else
            return Space.medium.rawValue
        #endif
    }

    private var surfaceHorizontalPadding: CGFloat {
        switch style {
        case .default:
            #if os(iOS)
                if horizontalSizeClass == .regular {
                    return Space.medium.rawValue + Space.large.rawValue
                } else {
                    return Space.medium.rawValue
                }
            #else
                return Space.medium.rawValue
            #endif
        case .smallIndent:
            return Space.xxSmall.rawValue
        case .edgeToEdge:
            return .zero
        }
    }

    private var surfaceVerticalPaddingSize: CGFloat {
        switch style {
        case .default:
            Space.small.rawValue
        case .smallIndent, .edgeToEdge:
            2
        }
    }
}

public extension SectionView {
    func sectionTitlePosition(_ position: SectionViewTitlePosition) -> SectionView {
        var control = self
        control.titlePosition = position
        return control
    }

    func sectionTitleButton(_ button: SectionViewTitleButton, position: SectionViewTitleButtonPosition = .trailing) -> SectionView {
        var control = self
        control.titleButton = button
        control.titleButtonPosition = position
        return control
    }
}

// MARK: - Preview

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: .zero) {
            SectionView("App") {
                Row("Label") {
                    IconDeprecated(.user)
                }
            }
            .sectionTitlePosition(.inside)

            SectionView("Feedback") {
                VStack(spacing: .zero) {
                    Row("Label") {
                        IconDeprecated(.user)
                    }
                    Row("Label") {
                        IconDeprecated(.user)
                    }
                }
            }
            .sectionTitlePosition(.inside)
            .sectionTitleButton(.title("All") {})

            SectionView("Feedback") {
                VStack(spacing: .zero) {
                    Row("Label") {
                        IconDeprecated(.user)
                    }

                    Row("Label") {
                        IconDeprecated(.user)
                    }
                }
            }
            .sectionTitlePosition(.inside)
            .sectionTitleButton(.arrow {})

            SectionView {
                Row("Cancel")
                    .multilineTextAlignment(.center)
            }

            Spacer()
        }
        .cornerRadius(.xLarge)
        .background(Color.backgroundSecondary.ignoresSafeArea(.all))
        .previewDisplayName("Default, title inside")

        VStack(spacing: .zero) {
            SectionView("App") {
                Row("Label") {
                    IconDeprecated(.user)
                }
            }
            .sectionTitlePosition(.inside)
            .sectionTitleButton(.title("All") {})
            .sectionViewStyle(.smallIndent)

            SectionView("Feedback") {
                VStack(spacing: .zero) {
                    Row("Label") {
                        IconDeprecated(.user)
                    }
                    Row("Label") {
                        IconDeprecated(.user)
                    }
                }
            }
            .sectionTitlePosition(.inside)
            .sectionViewStyle(.smallIndent)

            SectionView {
                Row("Cancel")
                    .multilineTextAlignment(.center)
            }
            .sectionViewStyle(.smallIndent)

            Spacer()
        }
        .background(Color.backgroundSecondary.ignoresSafeArea(.all))
        .previewDisplayName("Small Indent, title inside")

        VStack(spacing: .zero) {
            SectionView("App") {
                Row("Label") {
                    IconDeprecated(.user)
                }
            }
            .sectionTitlePosition(.inside)
            .sectionTitleButton(.title("All") {})
            .sectionViewStyle(.edgeToEdge)

            SectionView("Feedback") {
                VStack(spacing: .zero) {
                    Row("Label") {
                        IconDeprecated(.user)
                    }
                    Row("Label") {
                        IconDeprecated(.user)
                    }
                }
            }
            .sectionTitlePosition(.inside)
            .sectionViewStyle(.edgeToEdge)

            SectionView {
                Row("Cancel")
                    .multilineTextAlignment(.center)
            }
            .sectionViewStyle(.edgeToEdge)

            Spacer()
        }
        .background(Color.backgroundSecondary.ignoresSafeArea(.all))
        .previewDisplayName("Edge to Edge, title inside")

        VStack(spacing: .zero) {
            SectionView("App") {
                Row("Label") {
                    IconDeprecated(.user)
                }
            }

            SectionView("Feedback") {
                VStack(spacing: .zero) {
                    Row("Label") {
                        IconDeprecated(.user)
                    }
                    Row("Label") {
                        IconDeprecated(.user)
                    }
                }
            }

            SectionView {
                Row("Cancel")
                    .multilineTextAlignment(.center)
            }

            Spacer()
        }
        .background(Color.backgroundSecondary.ignoresSafeArea(.all))
        .previewDisplayName("Default")

        VStack(spacing: .zero) {
            SectionView("App") {
                Row("Label") {
                    IconDeprecated(.user)
                }
            }
            .sectionViewStyle(.smallIndent)

            SectionView("Feedback") {
                VStack(spacing: .zero) {
                    Row("Label") {
                        IconDeprecated(.user)
                    }
                    Row("Label") {
                        IconDeprecated(.user)
                    }
                }
            }
            .sectionViewStyle(.smallIndent)

            SectionView {
                Row("Cancel")
                    .multilineTextAlignment(.center)
            }
            .sectionViewStyle(.smallIndent)

            Spacer()
        }
        .background(Color.backgroundSecondary.ignoresSafeArea(.all))
        .previewDisplayName("Small Indent")

        VStack(spacing: .zero) {
            SectionView("App") {
                Row("Label") {
                    IconDeprecated(.user)
                }
            }
            .sectionViewStyle(.edgeToEdge)

            SectionView("Feedback") {
                VStack(spacing: .zero) {
                    Row("Label") {
                        IconDeprecated(.user)
                    }
                    Row("Label") {
                        IconDeprecated(.user)
                    }
                }
            }
            .sectionViewStyle(.edgeToEdge)

            SectionView {
                Row("Cancel")
                    .multilineTextAlignment(.center)
            }
            .sectionViewStyle(.edgeToEdge)

            Spacer()
        }
        .background(Color.backgroundSecondary.ignoresSafeArea(.all))
        .previewDisplayName("Edge to Edge")
    }
}

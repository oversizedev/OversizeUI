//
// Copyright © 2021 Alexander Romanov
// SectionView.swift, created on 07.02.2023
//

import SwiftUI

public enum SectionViewTitlePosition {
    case inside, outside
}

public enum SectionViewTitleButtonPosition {
    case leading, trailing
}

public enum SectionViewTitleButton {
    case arrow(_ action: () -> Void)
    case title(_ title: String, _ action: () -> Void)
}

public enum SectionViewStyle {
    case `default`, smallIndent, edgeToEdge
}

public struct SectionView<Content: View>: View {
    @Environment(\.controlRadius) private var controlRadius: Radius
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.sectionViewStyle) private var style: SectionViewStyle
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
                    .padding(.top, .xxSmall)
            }

            Surface {
                VStack(alignment: .leading, spacing: Space.xSmall) {
                    if !title.isEmpty, titlePosition == .inside {
                        titleView
                            .padding(.horizontal, .medium)
                    }
                    content
                }
                .padding(.vertical, contentVerticalPadding)
            }
            .padding(.horizontal, surfaceHorizontalPadding)
        }
        .padding(.vertical, surfaceVerticalPaddingSize)
    }

    private var titleView: some View {
        HStack {
            Text(title)
                .font(titleFont)
                .foregroundColor(titleColor)

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
            return .title2.weight(.bold)
        case .outside:
            return .headline
        }
    }

    private var titleColor: Color {
        switch titlePosition {
        case .inside:
            return .onSurfaceHighEmphasis
        case .outside:
            return .onBackgroundHighEmphasis
        }
    }

    @ViewBuilder
    private func titleButtonView(_ button: SectionViewTitleButton) -> some View {
        switch button {
        case let .arrow(action):
            Button {
                action()
            } label: {
                Icon(.chevronRight)
                    .iconColor(.onSurfaceMediumEmphasis)
            }
            .buttonStyle(.scale)
        case let .title(text, action):
            Button(text) { action() }
                .buttonStyle(.tertiary)
                .controlSize(.small)
                .controlBorderShape(.capsule)
        }
    }

    private var titleHorizontalPadding: CGFloat {
        if horizontalSizeClass == .regular {
            return Space.medium.rawValue + Space.large.rawValue
        } else {
            return Space.medium.rawValue
        }
    }

    private var surfaceHorizontalPadding: CGFloat {
        switch style {
        case .default:
            if horizontalSizeClass == .regular {
                return Space.medium.rawValue + Space.large.rawValue
            } else {
                return Space.medium.rawValue
            }
        case .smallIndent:
            return Space.xxSmall.rawValue
        case .edgeToEdge:
            return .zero
        }
    }

    private var contentVerticalPadding: CGFloat {
        switch titlePosition {
        case .inside:
            return 20
        case .outside:
            return .zero
        }
    }

    private var surfaceVerticalPaddingSize: CGFloat {
        switch style {
        case .default:
            return Space.small.rawValue
        case .smallIndent, .edgeToEdge:
            return 2
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
                    Icon(.user)
                }
            }
            .sectionTitlePosition(.inside)

            SectionView("Feedback") {
                VStack(spacing: .zero) {
                    Row("Label") {
                        Icon(.user)
                    }
                    Row("Label") {
                        Icon(.user)
                    }
                }
            }
            .sectionTitlePosition(.inside)
            .sectionTitleButton(.title("All") {})

            SectionView("Feedback") {
                VStack(spacing: .zero) {
                    Row("Label") {
                        Icon(.user)
                    }

                    Row("Label") {
                        Icon(.user)
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
                    Icon(.user)
                }
            }
            .sectionTitlePosition(.inside)
            .sectionTitleButton(.title("All") {})
            .sectionViewStyle(.smallIndent)

            SectionView("Feedback") {
                VStack(spacing: .zero) {
                    Row("Label") {
                        Icon(.user)
                    }
                    Row("Label") {
                        Icon(.user)
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
                    Icon(.user)
                }
            }
            .sectionTitlePosition(.inside)
            .sectionTitleButton(.title("All") {})
            .sectionViewStyle(.edgeToEdge)

            SectionView("Feedback") {
                VStack(spacing: .zero) {
                    Row("Label") {
                        Icon(.user)
                    }
                    Row("Label") {
                        Icon(.user)
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
                    Icon(.user)
                }
            }

            SectionView("Feedback") {
                VStack(spacing: .zero) {
                    Row("Label") {
                        Icon(.user)
                    }
                    Row("Label") {
                        Icon(.user)
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
                    Icon(.user)
                }
            }
            .sectionViewStyle(.smallIndent)

            SectionView("Feedback") {
                VStack(spacing: .zero) {
                    Row("Label") {
                        Icon(.user)
                    }
                    Row("Label") {
                        Icon(.user)
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
                    Icon(.user)
                }
            }
            .sectionViewStyle(.edgeToEdge)

            SectionView("Feedback") {
                VStack(spacing: .zero) {
                    Row("Label") {
                        Icon(.user)
                    }
                    Row("Label") {
                        Icon(.user)
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

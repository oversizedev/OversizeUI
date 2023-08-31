//
// Copyright © 2021 Alexander Romanov
// Row.swift, created on 14.06.2020
//

import SwiftUI

public enum RowClearIconStyle {
    case `default`, onSurface
}

public struct Row<LeadingLabel, TrailingLabel>: View where LeadingLabel: View, TrailingLabel: View {
    @Environment(\.elevation) private var elevation: Elevation
    @Environment(\.controlRadius) var controlRadius: Radius
    @Environment(\.rowContentMargins) var controlMargins: EdgeSpaceInsets
    @Environment(\.multilineTextAlignment) var multilineTextAlignment
    @Environment(\.isPremium) var premiumStatus
    @Environment(\.isAccent) var isAccent
    @Environment(\.isLoading) var isLoading

    private let title: String
    private let subtitle: String?

    private let leadingSize: CGSize?
    private let leadingRadius: CGFloat?

    private let leadingLabel: LeadingLabel?
    private let trailingLabel: TrailingLabel?

    private var leadingType: RowLeadingType?
    private var trallingType: RowTrailingType?

    private let action: (() -> Void)?

    private var isPremiumOption: Bool = false
    private var isShowArrowIcon: Bool = false

    private var iconBackgroundColor: Color?

    private var сlearButtonStyle: RowClearIconStyle = .default
    private var сlearAction: (() -> Void)?

    private var isShowSubtitle: Bool {
        (subtitle?.isEmpty) != nil
    }

    public init(_ title: String,
                subtitle: String? = nil,
                action: (() -> Void)? = nil,
                @ViewBuilder leading: () -> LeadingLabel,
                @ViewBuilder trailing: () -> TrailingLabel)
    {
        self.title = title
        self.subtitle = subtitle
        self.action = action
        leadingLabel = leading()
        trailingLabel = trailing()
        leadingSize = nil
        leadingRadius = nil
    }

    @available(*, deprecated, message: "Use leading: {} and tralling: {}")
    public init(_ title: String,
                subtitle: String? = nil,
                leadingType: RowLeadingType? = nil,
                trallingType: RowTrailingType? = nil,
                paddingHorizontal _: Space = .medium,
                paddingVertical _: Space = .small,
                action: (() -> Void)? = nil)
    {
        self.title = title
        self.subtitle = subtitle
        self.leadingType = leadingType
        self.trallingType = trallingType
        self.action = action
        leadingLabel = nil
        trailingLabel = nil
        leadingSize = nil
        leadingRadius = nil
    }

    public var body: some View {
        if action != nil {
            Button {
                if isPremiumOption == false || (isPremiumOption && premiumStatus) {
                    action?()
                }
            } label: {
                content(multilineTextAlignment)
            }
            .buttonStyle(.row)
        } else {
            content(multilineTextAlignment)
        }
    }

    @ViewBuilder
    private func content(_ textAlignment: TextAlignment) -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: .zero) {
                leadingLabel
                    .scaledToFill()
                    .frame(width: leadingSize?.width, height: leadingSize?.height)
                    .cornerRadius(leadingRadius ?? 0)
                    .padding(.trailing, .small)

                if textAlignment == .trailing || textAlignment == .center {
                    Spacer()
                }

                text

                premiumLabel

                if textAlignment == .leading || textAlignment == .center {
                    Spacer()
                }

                if isLoading {
                    ProgressView()
                        .padding(.trailing, .xSmall)
                }

                сlearButton

                trailingLabel
                    .padding(.leading, .xxSmall)

                if isShowArrowIcon {
                    Image.Base.chevronRight
                        .icon(.onSurfaceDisabled)
                }
            }
        }
        .padding(controlMargins)
    }

    private var text: some View {
        VStack(alignment: textAlignment, spacing: .zero) {
            Text(title)
                .headline(.medium)
                .foregroundColor(.onSurfaceHighEmphasis)
            if let subtitle, !subtitle.isEmpty {
                Text(subtitle)
                    .subheadline()
                    .foregroundColor(.onSurfaceMediumEmphasis)
            }
        }
        .multilineTextAlignment(multilineTextAlignment)
    }

    @ViewBuilder
    private var сlearButton: some View {
        if сlearAction != nil {
            Button {
                сlearAction?()
            } label: {
                ZStack {
                    IconDeprecated(.xMini, color: .onSurfaceDisabled)
                        .background(
                            RoundedRectangle(cornerRadius: .small, style: .continuous)
                                .fillSurfaceSecondary()
                                .opacity(сlearButtonStyle == .onSurface ? 1 : 0)
                        )
                }
            }
        }
    }

    @ViewBuilder
    private var premiumLabel: some View {
        if isPremiumOption, premiumStatus == false {
            PremiumLabel(text: "Pro", size: .small)
                .padding(.leading, .small)
        }
    }

    private var textAlignment: HorizontalAlignment {
        switch multilineTextAlignment {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        }
    }
}

// MARK: - Modificators

public extension Row {
    func premium(_ premium: Bool = true) -> Row {
        var control = self
        control.isPremiumOption = premium
        return control
    }

    func rowArrow(_ showArrowIcon: Bool = true) -> Row {
        var control = self
        control.isShowArrowIcon = showArrowIcon
        return control
    }

    func rowIconBackgroundColor(_ color: Color?) -> Row {
        var control = self
        control.iconBackgroundColor = color
        return control
    }

    func rowClearButton(style: RowClearIconStyle = .default, action: (() -> Void)?) -> Row {
        var control = self
        control.сlearButtonStyle = style
        control.сlearAction = action
        return control
    }

    @available(*, deprecated, message: "Use leading: {} and tralling: {}")
    func rowLeading(_ leading: RowLeadingType?) -> Row {
        var control = self
        control.leadingType = leading
        return control
    }

    @available(*, deprecated, message: "Use leading: {} and tralling: {}")
    func rowTrailing(_ trailing: RowTrailingType?) -> Row {
        var control = self
        control.trallingType = trailing
        return control
    }
}

public extension View {
    func rowOnSurface(_ elevation: Elevation = .z4, backgroundColor: Color? = nil) -> some View {
        Surface {
            self.rowContentMargins(.zero)
        }
        .surfaceBackgroundColor(backgroundColor)
        .elevation(elevation)
    }
}

// MARK: - Image init

public extension Row where LeadingLabel == Image, TrailingLabel == EmptyView {
    init(_ title: String,
         subtitle: String? = nil,
         action: (() -> Void)? = nil,
         @ViewBuilder leading: () -> LeadingLabel)
    {
        self.title = title
        self.subtitle = subtitle
        self.action = action
        leadingLabel = leading().resizable()
        trailingLabel = nil
        leadingSize = .init(
            width: subtitle == nil ? 24 : 48,
            height: subtitle == nil ? 24 : 48
        )
        leadingRadius = 4
    }
}

public extension Row where LeadingLabel == Image, TrailingLabel == EmptyView {
    init(_ title: String,
         subtitle: String? = nil,
         @ViewBuilder leading: () -> LeadingLabel)
    {
        self.title = title
        self.subtitle = subtitle
        action = nil
        leadingLabel = leading().resizable()
        trailingLabel = nil
        leadingSize = .init(
            width: subtitle == nil ? 24 : 48,
            height: subtitle == nil ? 24 : 48
        )
        leadingRadius = 4
    }
}

public extension Row where LeadingLabel == Image {
    init(_ title: String,
         subtitle: String? = nil,
         @ViewBuilder leading: () -> LeadingLabel,
         @ViewBuilder trailing: () -> TrailingLabel)
    {
        self.title = title
        self.subtitle = subtitle
        action = nil
        leadingLabel = leading()
            .resizable()
        trailingLabel = trailing()
        leadingSize = .init(
            width: subtitle == nil ? 24 : 48,
            height: subtitle == nil ? 24 : 48
        )
        leadingRadius = 4
    }
}

public extension Row where LeadingLabel == Image {
    init(_ title: String,
         subtitle: String? = nil,
         action: (() -> Void)? = nil,
         @ViewBuilder leading: () -> LeadingLabel,
         @ViewBuilder trailing: () -> TrailingLabel)
    {
        self.title = title
        self.subtitle = subtitle
        self.action = action
        leadingLabel = leading()
            .resizable()
        // .renderingMode(.template)
        trailingLabel = trailing()
        leadingSize = .init(
            width: subtitle == nil ? 24 : 48,
            height: subtitle == nil ? 24 : 48
        )
        leadingRadius = 4
    }
}

// MARK: - EmptyView

public extension Row where LeadingLabel == EmptyView, TrailingLabel == EmptyView {
    init(_ title: String,
         subtitle: String? = nil,
         action: (() -> Void)? = nil)
    {
        self.title = title
        self.subtitle = subtitle
        self.action = action
        leadingLabel = nil
        trailingLabel = nil
        leadingSize = nil
        leadingRadius = nil
    }
}

public extension Row where TrailingLabel == EmptyView {
    init(_ title: String,
         subtitle: String? = nil,
         action: (() -> Void)? = nil,
         @ViewBuilder leading: () -> LeadingLabel)
    {
        self.title = title
        self.subtitle = subtitle
        self.action = action
        leadingLabel = leading()
        trailingLabel = nil
        leadingSize = nil
        leadingRadius = nil
    }

    init(_ title: String,
         subtitle: String? = nil,
         @ViewBuilder leading: () -> LeadingLabel)
    {
        self.title = title
        self.subtitle = subtitle
        action = nil
        leadingLabel = leading()
        trailingLabel = nil
        leadingSize = nil
        leadingRadius = nil
    }
}

public extension Row where LeadingLabel == EmptyView {
    init(_ title: String,
         subtitle: String? = nil,
         action: (() -> Void)? = nil,
         @ViewBuilder trailing: () -> TrailingLabel)
    {
        self.title = title
        self.subtitle = subtitle
        self.action = action
        leadingLabel = nil
        trailingLabel = trailing()
        leadingSize = nil
        leadingRadius = nil
    }
}

// MARK: - Preview

// swiftlint:disable all
struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: .medium) {
            Row("Title")

            Row("Title", subtitle: "Subtitle")

            Row("Title", subtitle: "Subtitle") {
                IconDeprecated(.calendar)
            }

            Radio(isOn: true, label: {
                Row("Title", subtitle: "Subtitle") {
                    IconDeprecated(.calendar)
                }
            })

            Checkbox(isOn: .constant(true), label: {
                Row("Title", subtitle: "Subtitle") {
                    IconDeprecated(.calendar)
                }
                .rowOnSurface()
            })

            Row("Title", subtitle: "Red")
                .premium()
        }
        .previewLayout(.fixed(width: 375, height: 70))
    }
}

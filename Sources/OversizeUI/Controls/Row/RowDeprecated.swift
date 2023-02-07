//
// Copyright © 2023 Alexander Romanov
// RowNew.swift
//

import SwiftUI

public struct RowDeprecated: View {
    @Environment(\.elevation) private var elevation: Elevation
    @Environment(\.controlRadius) var controlRadius: Radius
    @Environment(\.rowContentInset) var controlPadding: EdgeSpaceInsets
    @Environment(\.multilineTextAlignment) var multilineTextAlignment
    @Environment(\.isPremium) var premiumStatus
    @Environment(\.isAccent) var isAccent
    @Environment(\.isLoading) var isLoading

    private let title: String
    private let subtitle: String?

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
                action: (() -> Void)? = nil)
    {
        self.title = title
        self.subtitle = subtitle
        self.action = action
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
            
                 if let leadingType {
                     RowLeading(leadingType, isShowSubtitle: isShowSubtitle, iconBackgroundColor: iconBackgroundColor)
                         .padding(.trailing, .small)
                 }
                

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

            
                 if let trallingType {
                     RowTrailing(trallingType, isPremiumOption: isPremiumOption)
                         .padding(.leading, .xxSmall)
                 }
        

                if isShowArrowIcon {
                    Icon(.chevronRight, color: .onSurfaceDisabled)
                }
            }
        }
        .padding(
            EdgeInsets(top: controlPadding.top,
                       leading: controlPadding.leading,
                       bottom: controlPadding.bottom,
                       trailing: controlPadding.trailing)
        )
    }

    private var text: some View {
        VStack(alignment: textAlignment, spacing: .xxxSmall) {
            Text(title)
                .headline(.semibold)
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
                    Icon(.xMini, color: .onSurfaceDisabled)
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

public extension RowDeprecated {
    func premium(_ premium: Bool = true) -> RowDeprecated {
        var control = self
        control.isPremiumOption = premium
        return control
    }

    func rowArrow(_ showArrowIcon: Bool = true) -> RowDeprecated {
        var control = self
        control.isShowArrowIcon = showArrowIcon
        return control
    }

    func rowIconBackgroundColor(_ color: Color?) -> RowDeprecated {
        var control = self
        control.iconBackgroundColor = color
        return control
    }

    func rowClearButton(style: RowClearIconStyle = .default, action: (() -> Void)?) -> RowDeprecated {
        var control = self
        control.сlearButtonStyle = style
        control.сlearAction = action
        return control
    }

    @available(*, deprecated, message: "Use leading: {} and tralling: {}")
    func rowLeading(_ leading: RowLeadingType?) -> RowDeprecated {
        var control = self
        control.leadingType = leading
        return control
    }

    @available(*, deprecated, message: "Use leading: {} and tralling: {}")
    func rowTrailing(_ trailing: RowTrailingType?) -> RowDeprecated {
        var control = self
        control.trallingType = trailing
        return control
    }
}

//public extension View {
//    func rowOnSurface(_ elevation: Elevation = .z4, backgroundColor: Color? = nil) -> some View {
//        Surface {
//            self.rowContentInset(.zero)
//        }
//        .surfaceBackgroundColor(backgroundColor)
//        .elevation(elevation)
//    }
//}

// MARK: - Preview

// swiftlint:disable all
struct ListRowDeprecated_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: .medium) {
            Row("Title")

            Row("Title", subtitle: "Subtitle")

            Row("Title", subtitle: "Subtitle") {
                Icon(.calendar)
            }

            Radio(isOn: true, label: {
                Row("Title", subtitle: "Subtitle") {
                    Icon(.calendar)
                }
            })

            Checkbox(isOn: .constant(true), label: {
                Row("Title", subtitle: "Subtitle") {
                    Icon(.calendar)
                }
                .rowOnSurface()
            })

//            Row("Title", subtitle: "Subtitle")
//                .rowLeading(.avatar(AvatarView(firstName: "Name")))
//                .rowTrailing(.text("Text"))

//            Row("Title")
//                .rowTrailing(.toggleWithArrowButton(isOn: .constant(true), action: nil))
//
//            Row("Title", subtitle: "Subtitle")
//                .rowTrailing(.button("Button", action: {}))

            Row("Title", subtitle: "Red")
                .premium()
        }
        .previewLayout(.fixed(width: 375, height: 70))
    }
}

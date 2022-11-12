//
// Copyright © 2022 Alexander Romanov
// Row.swift
//

import SwiftUI

public enum RowTrailingType {
    case radio(isOn: Binding<Bool>)
    case checkbox(isOn: Binding<Bool>)
    case toggle(isOn: Binding<Bool>)
    case toggleWithArrowButton(isOn: Binding<Bool>, action: (() -> Void)? = nil)
    @available(watchOS, unavailable)
    case timePicker(date: Binding<Date>)
    case arrowIcon
    case text(_ text: String)
    case button(_ text: String, action: () -> Void)
}

public enum RowLeadingType {
    case icon(_ name: IconsNames)
    case iconOnSurface(_ name: IconsNames)
    case image(_ image: Image, color: Color? = .onSurfaceHighEmphasis)
    case imageOnSurface(_ image: Image, color: Color? = nil)
    case systemImage(_ imageName: String)
    case avatar(_ avatar: AvatarView)
    case view(_ view: AnyView)
}

public struct Row: View {
    @Environment(\.elevation) private var elevation: Elevation
    @Environment(\.controlRadius) var controlRadius: Radius
    @Environment(\.controlPadding) var controlPadding: ControlPadding
    @Environment(\.multilineTextAlignment) var multilineTextAlignment
    @Environment(\.isPremium) var premiumStatus
    @Environment(\.isAccent) var isAccent

    private enum Constants {
        /// Spacing
        static var spacingIconAndText: Space { Space.xxSmall }
    }

    private let title: String
    private let subtitle: String?

    private var leadingType: RowLeadingType?
    private var trallingType: RowTrailingType?

    private let action: (() -> Void)?

    private var isPremiumOption: Bool = false

    private var iconBackgroundColor: Color?

    public init(_ title: String,
                subtitle: String? = nil,
                action: (() -> Void)? = nil)
    {
        self.title = title
        self.subtitle = subtitle
        self.action = action
    }

    // @available(*, deprecated, message: "Use row modificators")
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
                    leading(leadingType)
                        .padding(.trailing, .small)
                }

                if textAlignment == .trailing || textAlignment == .center {
                    Spacer()
                }

                text

                premiumLabel()

                if textAlignment == .leading || textAlignment == .center {
                    Spacer()
                }

                if let trallingType {
                    tralling(trallingType)
                        .padding(.leading, .xxSmall)
                }
            }
        }
        .padding(.vertical, verticalPadding)
        .padding(.horizontal, controlPadding.horizontal)
    }

    @ViewBuilder
    private func leading(_ leadingType: RowLeadingType) -> some View {
        switch leadingType {
        case let .icon(icon):
            Icon(icon)
                .padding(.trailing, Constants.spacingIconAndText)

        case let .image(image, color):
            image
                .renderingMode(color != nil ? .template : .original)
                .resizable()
                .scaledToFill()
                .foregroundColor(color)
                .frame(width: subtitle != nil ? 48 : 24, height: subtitle != nil ? 48 : 24)
                .cornerRadius(subtitle != nil ? 4 : 2)

        case let .avatar(avatar):
            avatar

        case let .iconOnSurface(icon):
            Surface {
                Icon(icon)
            }
            .surfaceStyle(.secondary)
            .surfaceBackgroundColor(iconBackgroundColor)
            .padding(.trailing, Constants.spacingIconAndText)
            .controlPadding(.xxSmall)

        case let .imageOnSurface(image, color):
            Surface {
                image
                    .renderingMode(.template)
                    .foregroundColor(color)
            }
            .surfaceStyle(.secondary)
            .surfaceBackgroundColor(iconBackgroundColor)
            .padding(.trailing, Constants.spacingIconAndText)
            .controlPadding(.xxSmall)

        case let .systemImage(systemImage):
            Image(systemName: systemImage)
                .foregroundColor(Color.onBackgroundHighEmphasis)
                .font(.system(size: 24))
                .frame(width: 24, height: 24, alignment: .center)
                .padding(.trailing, Constants.spacingIconAndText)

        case let .view(view):
            view
        }
    }

    // swiftlint:disable function_body_length
    @ViewBuilder
    private func tralling(_ trallingType: RowTrailingType) -> some View {
        switch trallingType {
        case let .toggle(isOn):
            Toggle(isOn: isOn) {}
                .labelsHidden()
                .disabled(isPremiumOption && premiumStatus == false)

        case let .radio(isOn: isOn):
            ZStack {
                Circle()
                    .stroke(Color.onSurfaceDisabled, lineWidth: 4)
                    .frame(width: 24, height: 24)
                    .cornerRadius(12)
                    .opacity(isOn.wrappedValue ? 0 : 1)

                Circle().fill(Color.accent)
                    .frame(width: 24, height: 24)
                    .cornerRadius(12)
                    .opacity(isOn.wrappedValue ? 1 : 0)

                Circle().fill(Color.white).frame(width: 8, height: 8)
                    .cornerRadius(4)
                    .opacity(isOn.wrappedValue ? 1 : 0)
            }

        case let .checkbox(isOn: isOn):
            ZStack {
                RoundedRectangle(cornerRadius: Radius.small, style: .continuous)
                    .stroke(Color.onSurfaceDisabled, lineWidth: 4)
                    .frame(width: 24, height: 24)
                    .opacity(isOn.wrappedValue ? 0 : 1)

                RoundedRectangle(cornerRadius: Radius.small, style: .continuous).fill(Color.accent)
                    .frame(width: 24, height: 24)
                    .opacity(isOn.wrappedValue ? 1 : 0)

                Image(systemName: "checkmark")
                    .font(.caption.weight(.black))
                    .foregroundColor(.onPrimaryHighEmphasis)
                    .opacity(isOn.wrappedValue ? 1 : 0)
            }

        case let .toggleWithArrowButton(isOn: isOn, action: action):
            HStack {
                Toggle(isOn: isOn) {}
                    .labelsHidden()

                Button(action: action ?? {}, label: {
                    Icon(.chevronRight, color: .onSurfaceDisabled)
                })
            }
            .disabled(isPremiumOption && premiumStatus == false)

        case .arrowIcon:
            Icon(.chevronRight, color: .onSurfaceDisabled)

        case let .timePicker(date: date):
            #if os(watchOS)
                EmptyView()
            #elseif os(iOS)
                DatePicker("", selection: date, displayedComponents: .hourAndMinute)
                    .labelsHidden()
            #endif
        case let .text(text):
            Text(text)
                .subheadline()
                .foregroundColor(.onSurfaceMediumEmphasis)

        case let .button(text, action: action):
            Button(text, action: action)
                .buttonStyle(.secondary)
                .controlBorderShape(.capsule)
                .controlSize(.small)
                .elevation(.z2)
                .disabled(isPremiumOption && premiumStatus == false)
        }
    }

    private var text: some View {
        VStack(alignment: textAlignment, spacing: .xxxSmall) {
            Text(title)
                .headline(.semibold)
                .foregroundColor(.onSurfaceHighEmphasis)
            if let subtitle {
                Text(subtitle)
                    .subheadline()
                    .foregroundColor(.onSurfaceMediumEmphasis)
            }
        }
        .multilineTextAlignment(multilineTextAlignment)
    }

    @ViewBuilder
    private func premiumLabel() -> some View {
        if isPremiumOption, premiumStatus == false {
            PremiumLabel(text: "Pro", size: .small)
                .padding(.leading, .small)
        } else {
            EmptyView()
        }
    }

    private var verticalPadding: CGFloat {
        switch controlPadding.vertical {
        case .zero:
            return .zero
        case .xxSmall:
            return .zero
        default:
            return controlPadding.vertical.rawValue - Space.xxSmall.rawValue
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

    // Modificators
    public func premium(_ premium: Bool = true) -> Row {
        var control = self
        control.isPremiumOption = premium
        return control
    }

    public func rowLeading(_ leading: RowLeadingType?) -> Row {
        var control = self
        control.leadingType = leading
        return control
    }

    public func rowTrailing(_ trailing: RowTrailingType?) -> Row {
        var control = self
        control.trallingType = trailing
        return control
    }

    public func rowIconBackgroundColor(_ color: Color?) -> Row {
        var control = self
        control.iconBackgroundColor = color
        return control
    }
}

public extension View {
    func rowOnSurface(_ elevation: Elevation = .z4) -> some View {
        Surface {
            self.controlPadding(.zero)
        }
        .elevation(elevation)
    }
}

public struct RowActionButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.surfaceSecondary : Color.clear)
            .contentShape(Rectangle())
    }
}

public extension ButtonStyle where Self == RowActionButtonStyle {
    static var row: RowActionButtonStyle {
        RowActionButtonStyle()
    }
}

// swiftlint:disable all
struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Row("Title")

            Row("Title", subtitle: "Subtitle")

            Row("Title", subtitle: "Subtitle")
                .rowLeading(.icon(.calendar))
                .rowTrailing(.radio(isOn: .constant(true)))

            Row("Title", subtitle: "Subtitle")
                .rowLeading(.iconOnSurface(.calendar))
                .rowTrailing(.toggle(isOn: .constant(true)))

            Row("Title", subtitle: "Subtitle")
                .rowLeading(.icon(.calendar))
                .rowTrailing(.checkbox(isOn: .constant(true)))
                .rowOnSurface()
                .padding()
                .previewLayout(.fixed(width: 375, height: 120))

            Row("Title", subtitle: "Subtitle")
                .rowLeading(.avatar(AvatarView(firstName: "Name")))
                .rowTrailing(.text("Text"))

            Row("Title")
                .rowTrailing(.toggleWithArrowButton(isOn: .constant(true), action: nil))

            Row("Title", subtitle: "Subtitle")
                .rowTrailing(.button("Button", action: {}))

            Row("Title", subtitle: "Red")
                .premium()
        }
        .previewLayout(.fixed(width: 375, height: 70))
    }
}

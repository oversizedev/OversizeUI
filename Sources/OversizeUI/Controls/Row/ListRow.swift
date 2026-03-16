//
// Copyright © 2021 Alexander Romanov
// ListRow.swift, created on 13.03.2026
//

import SwiftUI

public struct ListRow<LeadingLabel: View, TrailingLabel: View>: View {
    @Environment(\.elevation) private var elevation: Elevation
    @Environment(\.rowContentMargins) var controlMargins: EdgeInsets
    @Environment(\.multilineTextAlignment) var multilineTextAlignment
    @Environment(\.isPremium) var premiumStatus
    @Environment(\.isLoading) var isLoading

    private let title: String
    private let subtitle: String?

    private let leadingSize: CGSize?
    private let leadingRadius: CGFloat?

    private let leadingLabel: LeadingLabel?
    private let trailingLabel: TrailingLabel?

    private var isPremiumOption = false
    private var leadingSpace: CGFloat = .small
    private var textColor: Color?

    public init(
        _ title: String,
        subtitle: String? = nil,
        @ViewBuilder leading: () -> LeadingLabel,
        @ViewBuilder trailing: () -> TrailingLabel
    ) {
        self.title = title
        self.subtitle = subtitle
        leadingLabel = leading()
        trailingLabel = trailing()
        leadingSize = nil
        leadingRadius = nil
    }

    public var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: .zero) {
                leadingLabel
                    .scaledToFill()
                    .frame(width: leadingSize?.width, height: leadingSize?.height)
                    .cornerRadius(leadingRadius ?? 0)
                    .padding(.trailing, leadingSpace)

                text

                premiumLabel

                if isLoading {
                    ProgressView()
                        .padding(.trailing, .xSmall)
                }

                trailingLabel
                    .padding(.leading, .xxSmall)
            }
        }
        .listRowInsets(controlMargins)
        .contentShape(Rectangle())
    }

    private var text: some View {
        VStack(alignment: textAlignment, spacing: .zero) {
            Text(title)
                .headline(.medium)
                .foregroundColor(titleTextColor)
                .frame(maxWidth: .infinity, alignment: alignment)

            if let subtitle, !subtitle.isEmpty {
                Text(subtitle)
                    .subheadline()
                    .foregroundColor(subtitleTextColor)
                    .frame(maxWidth: .infinity, alignment: alignment)
            }
        }
        .multilineTextAlignment(multilineTextAlignment)
    }

    @ViewBuilder
    private var premiumLabel: some View {
        if isPremiumOption, premiumStatus == false {
            PremiumLabel(text: "Pro", size: .small)
                .padding(.leading, .small)
        }
    }

    private var titleTextColor: Color {
        if let textColor {
            textColor
        } else {
            Color.onSurfacePrimary
        }
    }

    private var subtitleTextColor: Color {
        if let textColor {
            textColor
        } else {
            Color.onSurfaceSecondary
        }
    }

    private var textAlignment: HorizontalAlignment {
        switch multilineTextAlignment {
        case .leading:
            .leading
        case .center:
            .center
        case .trailing:
            .trailing
        }
    }

    private var alignment: Alignment {
        switch multilineTextAlignment {
        case .leading:
            .leading
        case .center:
            .center
        case .trailing:
            .trailing
        }
    }
}

// MARK: - Modificators

public extension ListRow {
    func premium(_ premium: Bool = true) -> ListRow {
        var control = self
        control.isPremiumOption = premium
        return control
    }

    func leadingContentMargin(_ margin: CGFloat = .small) -> ListRow {
        var control = self
        control.leadingSpace = margin
        return control
    }

    func rowTextColor(_ color: Color?) -> ListRow {
        var control = self
        control.textColor = color
        return control
    }
}

// MARK: - Image init

public extension ListRow where LeadingLabel == Image, TrailingLabel == EmptyView {
    init(
        _ title: String,
        subtitle: String? = nil,
        @ViewBuilder leading: () -> LeadingLabel
    ) {
        self.title = title
        self.subtitle = subtitle
        leadingLabel = leading().resizable()
        trailingLabel = nil
        #if os(macOS)
        leadingSize = .init(
            width: subtitle == nil ? 20 : 40,
            height: subtitle == nil ? 20 : 40
        )
        #else
        leadingSize = .init(
            width: subtitle == nil ? 24 : 48,
            height: subtitle == nil ? 24 : 48
        )
        #endif
        leadingRadius = 4
    }
}

public extension ListRow where LeadingLabel == Image {
    init(
        _ title: String,
        subtitle: String? = nil,
        @ViewBuilder leading: () -> LeadingLabel,
        @ViewBuilder trailing: () -> TrailingLabel
    ) {
        self.title = title
        self.subtitle = subtitle
        leadingLabel = leading().resizable()
        trailingLabel = trailing()
        #if os(macOS)
        leadingSize = .init(
            width: subtitle == nil ? 20 : 40,
            height: subtitle == nil ? 20 : 40
        )
        #else
        leadingSize = .init(
            width: subtitle == nil ? 24 : 48,
            height: subtitle == nil ? 24 : 48
        )
        #endif
        leadingRadius = 4
    }
}

// MARK: - EmptyView

public extension ListRow where LeadingLabel == EmptyView, TrailingLabel == EmptyView {
    init(
        _ title: String,
        subtitle: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        leadingLabel = nil
        trailingLabel = nil
        leadingSize = nil
        leadingRadius = nil
    }
}

public extension ListRow where TrailingLabel == EmptyView {
    init(
        _ title: String,
        subtitle: String? = nil,
        @ViewBuilder leading: () -> LeadingLabel
    ) {
        self.title = title
        self.subtitle = subtitle
        leadingLabel = leading()
        trailingLabel = nil
        leadingSize = nil
        leadingRadius = nil
    }
}

public extension ListRow where LeadingLabel == EmptyView {
    init(
        _ title: String,
        subtitle: String? = nil,
        @ViewBuilder trailing: () -> TrailingLabel
    ) {
        self.title = title
        self.subtitle = subtitle
        leadingLabel = nil
        trailingLabel = trailing()
        leadingSize = nil
        leadingRadius = nil
    }
}

// MARK: - Preview

// swiftlint:disable all
#Preview {
    VStack(spacing: .medium) {
        ListRow("Title")

        ListRow("Title", subtitle: "Subtitle")

        ListRow("Title", subtitle: "Subtitle", leading: {
            Image.Base.calendar.icon()
        })

        ListRow("Title", trailing: {
            Text("Value")
                .subheadline()
                .foregroundColor(.onSurfaceSecondary)
        })

        ListRow("Title", subtitle: "Premium feature")
            .premium()

        ListRow("Center", leading: {
            Image.Base.calendar.icon()
        }, trailing: {
            Toggle("", isOn: .constant(true))
                .labelsHidden()
        })
        .multilineTextAlignment(.center)

        ListRow("Trailing", leading: {
            Image.Base.calendar.icon()
        }, trailing: {
            Toggle("", isOn: .constant(true))
                .labelsHidden()
        })
        .multilineTextAlignment(.trailing)
    }
    .padding()
}

#Preview {
    List {
        ListRow("Plain row")

        ListRow("With subtitle", subtitle: "Some description")

        ListRow("With leading", leading: {
            Image.Base.calendar.icon()
        })

        ListRow("With trailing", trailing: {
            Toggle("", isOn: .constant(true))
                .labelsHidden()
        })

        NavigationLink("Nav link") {
            Text("Detail")
        }

        ListRow("Premium row")
            .premium()

        ListRow("Plain row")

        ListRow("Center", leading: {
            Image.Base.calendar.icon()
        }, trailing: {
            Toggle("", isOn: .constant(true))
                .labelsHidden()
        })
        .multilineTextAlignment(.center)

        ListRow("Trailing", leading: {
            Image.Base.calendar.icon()
        }, trailing: {
            Toggle("", isOn: .constant(true))
                .labelsHidden()
        })
        .multilineTextAlignment(.trailing)
    }
}

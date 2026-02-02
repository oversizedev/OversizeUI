//
// Copyright © 2024 Alexander Romanov
// SuccessView.swift, created on 15.11.2024
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct SuccessView<C: View, A: View>: View {
    private let image: Image?
    private let title: String
    private let subtitle: String?
    private let actions: Group<A>?
    private let content: C?

    public init(
        image: Image? = nil,
        title: String,
        subtitle: String? = nil,
        @ViewBuilder actions: @escaping () -> A,
        @ViewBuilder content: () -> C = { EmptyView() }
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.actions = Group { actions() }
        self.content = content()
    }

    public var body: some View {
        #if os(macOS)
        macOSContentView
        #else
        contenView
        #endif
    }

    private var contenView: some View {
        VStack(alignment: .center, spacing: .large) {
            Spacer()
            displayImage
                .frame(width: 128, height: 128, alignment: .bottom)

            TextBox(
                title: title,
                subtitle: subtitle,
                spacing: .xxSmall
            )
            .multilineTextAlignment(.center)

            if let content {
                content
            }

            if actions != nil {
                VStack(spacing: .small) {
                    actions
                    #if !os(tvOS)
                    .controlSize(.large)
                    #endif
                }
                .padding(.top, .xxSmall)
            }

            Spacer()
        }
        .paddingContent()
        .containerRelativeFrame([.horizontal, .vertical])
    }

    private var macOSContentView: some View {
        HStack(spacing: .medium) {
            VStack(alignment: .center, spacing: .large) {
                Spacer()

                displayImage
                    .frame(width: 64, height: 64, alignment: .bottom)

                TextBox(
                    title: title,
                    subtitle: subtitle,
                    spacing: .xxSmall
                )
                .multilineTextAlignment(.center)

                if actions != nil {
                    VStack(spacing: .small) {
                        actions
                            .controlSize(.large)
                    }
                    .frame(width: 200)
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .center)

            if let content {
                Surface {
                    content
                }
                .surfaceClip(true)
                .surfaceStyle(.secondary)
                .surfaceContentMargins(.zero)
            }
        }
        .paddingContent()
        .containerRelativeFrame([.horizontal, .vertical])
    }

    private var displayImage: Image {
        if let image {
            image
                .resizable()
        } else {
            Image.Illustration.Status.success
                .resizable()
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Basic Success") {
    SuccessView(
        title: "Success!",
        subtitle: "Your operation completed successfully.",
        actions: {
            Button("Continue") {}
                .buttonStyle(.primary(infinityWidth: true))
                .accent()
                .elevation(.z2)
        }
    )
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Success with Content") {
    SuccessView(
        title: "Account Created",
        subtitle: "Welcome to our platform!",
        actions: {
            Button("Get Started") {}
                .buttonStyle(.primary)
        },
        content: {
            VStack(alignment: .leading, spacing: .medium) {
                Text("Next Steps:")
                    .font(.headline)
                VStack(alignment: .leading, spacing: .small) {
                    Label("Complete your profile", systemImage: "person.circle")
                    Label("Verify your email", systemImage: "envelope")
                    Label("Explore features", systemImage: "sparkles")
                }
                .font(.body)
            }
            .padding()
        }
    )
}

//
// Copyright © 2024 Alexander Romanov
// SuccessView.swift, created on 15.11.2024
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct SuccessView<C, A>: View where C: View, A: View {
    private let image: Image?
    private let title: String
    private let subtitle: String?
    private let closeAction: (() -> Void)?
    private let actions: Group<A>?
    private let content: C?

    public init(
        image: Image? = nil,
        title: String,
        subtitle: String? = nil,
        closeAction: (() -> Void)? = nil,
        @ViewBuilder actions: @escaping () -> A,
        @ViewBuilder content: () -> C = { EmptyView() }
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.closeAction = closeAction
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
        GeometryReader { geometry in
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
                    VStack {
                        content

                        Spacer()
                    }
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
            }
            .paddingContent()
            .frame(
                width: geometry.bounds(of: .scrollView)?.width ?? geometry.size.width,
                height: geometry.bounds(of: .scrollView)?.height ?? geometry.size.height
            )
        }
    }

    private var macOSContentView: some View {
        GeometryReader { geometry in
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
            .frame(
                width: geometry.bounds(of: .scrollView)?.width ?? geometry.size.width,
                height: geometry.bounds(of: .scrollView)?.height ?? geometry.size.height
            )
        }
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
#Preview("Basic in ScrollView") {
    ScrollView {
        SuccessView(
            title: "Success!",
            subtitle: "Your operation completed successfully.",
            actions: {
                Button("Continue") {}
                    .buttonStyle(.primary)
            }
        )
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Custom Image with Multiple Actions") {
    SuccessView(
        image: Image(systemName: "checkmark.circle.fill"),
        title: "Payment Complete",
        subtitle: "Your payment has been processed successfully.",
        actions: {
            VStack(spacing: .small) {
                Button("View Receipt") {}
                    .buttonStyle(.primary)
                Button("Continue Shopping") {}
                    .buttonStyle(.secondary)
            }
        }
    )
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("With Content") {
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

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("With Close Action") {
    SuccessView(
        title: "File Uploaded",
        subtitle: "Your document has been uploaded successfully.",
        closeAction: { print("Close tapped") },
        actions: {
            Button("View File") {}
                .buttonStyle(.primary)
        }
    )
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Minimal") {
    SuccessView(
        title: "Done!",
        actions: {
            Button("OK") {}
                .buttonStyle(.primary)
        }
    )
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("No Actions with Stats") {
    SuccessView(
        title: "Backup Complete",
        subtitle: "Your data has been safely backed up to the cloud.",
        actions: {
            EmptyView()
        },
        content: {
            VStack(spacing: .medium) {
                HStack {
                    Text("Files backed up:")
                    Spacer()
                    Text("1,247")
                        .font(.headline)
                }
                HStack {
                    Text("Total size:")
                    Spacer()
                    Text("2.4 GB")
                        .font(.headline)
                }
                HStack {
                    Text("Last backup:")
                    Spacer()
                    Text("Just now")
                        .font(.headline)
                }
            }
            .padding()
        }
    )
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Dark Mode") {
    SuccessView(
        title: "Settings Saved",
        subtitle: "Your preferences have been updated.",
        actions: {
            Button("Done") {}
                .buttonStyle(.primary)
        }
    )
    .preferredColorScheme(.dark)
}

#if os(macOS)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("macOS Layout") {
    SuccessView(
        title: "Export Complete",
        subtitle: "Your project has been exported successfully.",
        actions: {
            HStack {
                Button("Show in Finder") {}
                    .buttonStyle(.secondary)
                Button("Share") {}
                    .buttonStyle(.primary)
            }
        },
        content: {
            VStack(alignment: .leading, spacing: .medium) {
                Text("Export Details")
                    .font(.headline)

                VStack(alignment: .leading, spacing: .small) {
                    HStack {
                        Text("Format:")
                        Spacer()
                        Text("PDF")
                    }
                    HStack {
                        Text("Pages:")
                        Spacer()
                        Text("24")
                    }
                    HStack {
                        Text("File size:")
                        Spacer()
                        Text("3.2 MB")
                    }
                }
                .font(.body)
            }
            .padding()
        }
    )
    .frame(width: 600, height: 400)
}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Long Title and Subtitle") {
    SuccessView(
        title: "Your Very Important Task Has Been Completed Successfully",
        subtitle: "This is a longer subtitle text to demonstrate how the SuccessView handles multiple lines of text and proper text wrapping in different scenarios.",
        actions: {
            VStack(spacing: .small) {
                Button("Primary Action") {}
                    .buttonStyle(.primary)
                Button("Secondary Action") {}
                    .buttonStyle(.secondary)
                Button("Tertiary Action") {}
                    .buttonStyle(.tertiary)
            }
        }
    )
}

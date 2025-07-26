//
// Copyright © 2024 Alexander Romanov
// ErrorView.swift, created on 15.11.2024
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct ErrorView: View {
    private let error: Error
    private let closeAction: (() -> Void)?
    private let recoveryHandler: ((Int) -> Void)?
    private var image: Image?

    public init(
        error: Error,
        closeAction: (() -> Void)? = nil,
        recoveryHandler: ((Int) -> Void)? = nil
    ) {
        self.error = error
        self.closeAction = closeAction
        self.recoveryHandler = recoveryHandler
    }

    public var body: some View {
        #if os(macOS)
        macOSContentView
        #else
        contenView
        #endif
    }

    private var title: String {
        if let localizedError = error as? LocalizedError {
            return localizedError.errorDescription ?? "Error"
        }
        return error.localizedDescription
    }

    private var subtitle: String {
        if let localizedError = error as? LocalizedError {
            return [
                localizedError.failureReason,
                localizedError.recoverySuggestion,
            ].compactMap { $0 }.joined(separator: "\n")
        }
        return ""
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

                Spacer()
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

                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .center)
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
            Image.Illustration.Status.error
                .resizable()
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Basic Success") {
    enum AuthError: Error, LocalizedError, Sendable {
        case networkError
        case notAccess
        case invalidCredentials

        public var errorDescription: String? {
            switch self {
            case .networkError:
                "Invalid phone number format"
            case .notAccess:
                "No access to location services"
            case .invalidCredentials:
                "Invalid credentials provided"
            }
        }

        public var failureReason: String? {
            switch self {
            case .networkError:
                "Please enter a valid phone number"
            case .notAccess:
                "Location services are not enabled"
            case .invalidCredentials:
                "The credentials you provided are incorrect"
            }
        }
    }

    let errorView = ErrorView(error: AuthError.networkError)

    return errorView
}

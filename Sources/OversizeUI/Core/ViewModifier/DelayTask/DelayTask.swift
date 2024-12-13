//
// Copyright © 2024 Alexander Romanov
// DelayTaskViewModifier.swift, created on 13.11.2024
//

import SwiftUI

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 13.0, *)
struct DelayTaskViewModifier: ViewModifier {
    let delay: ContinuousClock.Instant.Duration
    let action: @Sendable () async -> Void

    func body(content: Content) -> some View {
        content
            .task {
                do {
                    try await Task.sleep(for: delay)
                    await action()
                } catch {}
            }
    }
}

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 13.0, *)
public extension View {
    func task(
        delay: ContinuousClock.Duration,
        action: @Sendable @escaping () async -> Void
    ) -> some View {
        modifier(DelayTaskViewModifier(delay: delay, action: action))
    }
}

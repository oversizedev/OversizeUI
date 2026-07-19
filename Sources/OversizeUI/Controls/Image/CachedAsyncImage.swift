//
// Copyright © 2026 Alexander Romanov
// CachedAsyncImage.swift, created on 08.05.2026
//

import SwiftUI

public struct CachedAsyncImage<Content: View>: View {
    @State private var phase: AsyncImagePhase

    private let urlRequest: URLRequest?
    private let urlSession: URLSession
    private let urlCache: URLCache
    private let scale: CGFloat
    private let content: (AsyncImagePhase) -> Content

    public init<I, P>(
        url: URL?,
        urlCache: URLCache = .shared,
        scale: CGFloat = 1,
        @ViewBuilder content: @escaping (Image) -> I,
        @ViewBuilder placeholder: @escaping () -> P
    ) where Content == _ConditionalContent<I, P>, I: View, P: View {
        let urlRequest = url == nil ? nil : URLRequest(url: url!)
        self.init(urlRequest: urlRequest, urlCache: urlCache, scale: scale) { phase in
            if let image = phase.image {
                content(image)
            } else {
                placeholder()
            }
        }
    }

    public init(
        url: URL?,
        urlCache: URLCache = .shared,
        scale: CGFloat = 1,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        let urlRequest = url == nil ? nil : URLRequest(url: url!)
        self.init(urlRequest: urlRequest, urlCache: urlCache, scale: scale, content: content)
    }

    public init(
        urlRequest: URLRequest?,
        urlCache: URLCache = .shared,
        scale: CGFloat = 1,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        urlSession = CachedAsyncImageSessionStore.session(for: urlCache)
        self.urlRequest = urlRequest
        self.urlCache = urlCache
        self.scale = scale
        self.content = content

        _phase = State(wrappedValue: .empty)
        if let urlRequest, let image = cachedImage(from: urlRequest, cache: urlCache) {
            _phase = State(wrappedValue: .success(image))
        }
    }

    public var body: some View {
        content(phase)
            .task(id: urlRequest, load)
    }

    @Sendable private func load() async {
        guard let urlRequest else {
            phase = .empty
            return
        }
        if let cached = cachedImage(from: urlRequest, cache: urlCache) {
            phase = .success(cached)
        }
        do {
            let image = try await remoteImage(from: urlRequest, session: urlSession)
            withAnimation {
                phase = .success(image)
            }
        } catch {
            if cachedImage(from: urlRequest, cache: urlCache) == nil {
                withAnimation {
                    phase = .failure(error)
                }
            }
        }
    }
}

private extension CachedAsyncImage {
    func remoteImage(from request: URLRequest, session: URLSession) async throws -> Image {
        let (data, _) = try await session.data(for: request)
        guard let image = image(from: data) else { throw LoadingError() }
        return image
    }

    func cachedImage(from request: URLRequest, cache: URLCache) -> Image? {
        guard let cachedResponse = cache.cachedResponse(for: request) else { return nil }
        return image(from: cachedResponse.data)
    }

    func image(from data: Data) -> Image? {
        #if os(macOS)
        NSImage(data: data).map { Image(nsImage: $0) }
        #else
        UIImage(data: data, scale: scale).map { Image(uiImage: $0) }
        #endif
    }

    struct LoadingError: Error {}
}

private enum CachedAsyncImageSessionStore {
    nonisolated(unsafe) private static var sessions: [ObjectIdentifier: URLSession] = [:]
    private static let lock = NSLock()

    static func session(for urlCache: URLCache) -> URLSession {
        let key = ObjectIdentifier(urlCache)
        lock.lock()
        defer { lock.unlock() }
        if let existing = sessions[key] {
            return existing
        }
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = urlCache
        let session = URLSession(configuration: configuration)
        sessions[key] = session
        return session
    }
}

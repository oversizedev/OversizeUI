//
// Copyright © 2022 Alexander Romanov
// RawRepresentable.swift
//

import SwiftUI

extension Date: RawRepresentable {
    private static let formatter: ISO8601DateFormatter = .init()

    public var rawValue: String {
        Date.formatter.string(from: self)
    }

    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result: String = .init(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

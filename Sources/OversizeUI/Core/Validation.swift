//
// Copyright © 2023 Alexander Romanov
// Validation.swift
//

import Foundation

public enum Validation {
    case success
    case failure(message: String)

    public var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
}

//
// Copyright © 2021 Alexander Romanov
// Validation.swift, created on 02.02.2023
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

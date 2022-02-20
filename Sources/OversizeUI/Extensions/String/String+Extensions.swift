//
// Copyright © 2022 Alexander Romanov
// String+Extensions.swift
//

import Foundation
import SwiftUI

extension String {
    public func capitalizingFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = capitalizingFirstLetter()
    }
}

extension String {
    public func lowercasingFirstLetter() -> String {
        prefix(1).lowercased() + dropFirst()
    }

    mutating func lowercasedFirstLetter() {
        self = lowercasingFirstLetter()
    }
}

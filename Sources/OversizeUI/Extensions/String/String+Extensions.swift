//
// Copyright © 2021 Alexander Romanov
// Created on 26.08.2021
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

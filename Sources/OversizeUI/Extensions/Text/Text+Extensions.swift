//
// Copyright © 2022 Alexander Romanov
// Text+Extensions.swift
//

import SwiftUI

public extension Text {
    init(localize: LocalizedStringKey) {
        self = Text(localize, bundle: .module)
    }
}

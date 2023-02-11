//
// Copyright © 2021 Alexander Romanov
// Text+Extensions.swift, created on 23.04.2021
//

import SwiftUI

public extension Text {
    init(localize: LocalizedStringKey) {
        self = Text(localize, bundle: .module)
    }
}

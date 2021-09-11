//
// Copyright © 2021 Alexander Romanov
// Created on 26.08.2021
//

import SwiftUI

public extension Text {
    init(localize: LocalizedStringKey) {
        self = Text(localize, bundle: .module)
    }
}

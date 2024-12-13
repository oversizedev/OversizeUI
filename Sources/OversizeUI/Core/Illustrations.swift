//
// Copyright © 2024 Alexander Romanov
// Illustration.swift, created on 16.11.2024
//

import SwiftUI

public extension SwiftUI.Image {
    enum Illustration {
        public enum Status {
            public static let success = Image("Status/Success", bundle: .module)
            public static let error = Image("Status/Error", bundle: .module)
            public static let warning = Image("Status/Warning", bundle: .module)
            public enum Warning {
                public static let fill = Image("Status/Warning/Triangle", bundle: .module)
            }
        }
    }
}

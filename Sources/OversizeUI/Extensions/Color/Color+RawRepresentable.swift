//
// Copyright © 2021 Alexander Romanov
// Color+RawRepresentable.swift, created on 11.09.2021
//

#if os(iOS)
import Foundation
import SwiftUI
import UIKit

extension Color: RawRepresentable {
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    public init?(rawValue: String) {
        guard let data = Data(base64Encoded: rawValue) else {
            self = .blue
            return
        }

        do {
            let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor ?? .blue
            self = Color(color)
        } catch {
            self = .black
        }
    }

    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    public var rawValue: String {
        do {
            // swiftlint:disable line_length
            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
            return data.base64EncodedString()

        } catch {
            return ""
        }
    }
}

#endif

//
// Copyright © 2021 Aleksandr Romanov
// AvatarModifiers.swift, created on 10.03.2023
//

import SwiftUI

public extension Avatar {
    /// Sets a custom background color or gradient for the Avatar.
    /// - Parameter background: Avatar Background color.
    /// - Returns: The modified Avatar with the property set.
    func avatarBackground(_ background: AvatarBackgroundType) -> Avatar {
        var control = self
        control.background = background
        return control
    }

    /// Sets a custom text and image color for the Avatar.
    /// - Parameter color: Avatar text and image color
    /// - Returns: The modified Avatar with the property set.
    func avatarOnBackground(_ color: Color) -> Avatar {
        var control = self
        control.onBackgroundColor = color
        return control
    }

    /// Sets a stroke for the Avatar
    /// - Parameter strokeColor: Color for Avatar stroke
    /// - Returns: The modified view with stroke.
    func avatarStroke(_ strokeColor: Color = .surfacePrimary, lineWidth: CGFloat = 2) -> Avatar {
        var control = self
        control.strokeColor = strokeColor
        control.strokeLineWidth = lineWidth
        return control
    }
}

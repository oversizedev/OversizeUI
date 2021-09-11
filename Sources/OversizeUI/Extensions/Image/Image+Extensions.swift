//
// Copyright © 2021 Alexander Romanov
// Created on 26.08.2021
//

import SwiftUI

public extension Image {
    func resizeToFill(width: CGFloat, height: CGFloat) -> some View {
        resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
    }
}

//
// Copyright © 2026 Alexander Romanov
// PriceFieldDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

#if os(iOS) || os(macOS)
@available(iOS 16.0, macOS 14.0, *)
struct PriceFieldDemo: View {
    @State private var amount: Decimal = 0

    var body: some View {
        DemoScreen {
            DemoSectionView("Price field") {
                PriceField(amount: $amount, currency: .init("USD"))
                    .accessibilityIdentifier("priceField")
            }
        }
    }
}

@available(iOS 16.0, macOS 14.0, *)
#Preview {
    NavigationStack {
        PriceFieldDemo()
    }
}
#endif

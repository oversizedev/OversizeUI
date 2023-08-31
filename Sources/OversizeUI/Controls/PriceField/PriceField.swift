//
// Copyright © 2023 Alexander Romanov
// PriceField.swift, created on 15.03.2023
//

import Foundation
import SwiftUI

@available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
public struct PriceField: View {
    @Binding private var amount: Decimal
    private let currency: Locale.Currency

    public init(amount: Binding<Decimal>, currency: Locale.Currency) {
        _amount = amount
        self.currency = currency
    }

    public var body: some View {
        #if os(iOS)
        TextField(
            "0",
            value: $amount,
            format: .currency(code: currency.identifier)
        )
        .keyboardType(.decimalPad)
        .textFieldStyle(.default)
        #else
        TextField(
            "0",
            value: $amount,
            format: .currency(code: currency.identifier)
        )
        .textFieldStyle(.default)
        #endif
    }
}

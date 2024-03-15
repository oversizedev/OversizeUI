//
// Copyright © 2023 Alexander Romanov
// PriceField.swift, created on 15.03.2023
//

import Foundation
import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

@available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
public struct PriceField: View {
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = "."
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }

    private var strValue2: String { value.components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined() } // value.filter { !$0.isWhitespace } }
    private var doubleValue2: Double { .init((Double(strValue2) ?? 0) / 100.0) ?? 0 }

    private var strValue3: String { value.components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined() } // value.filter { !$0.isWhitespace } }
    private var doubleValue3: Double { .init((Double(strValue3) ?? 0) * 100) ?? 0 }

    private var strValue: String { value.filter { !$0.isWhitespace } }
    private var doubleValue: Double { .init(strValue) ?? 0 }
    private var formattedValue: String {
        let value = doubleValue

        return formatter.string(for: value) ?? ""
    }

    private var formattedValue2: String {
        let value = doubleValue2

        return formatter.string(for: value) ?? ""
    }

    @Binding private var amount: Decimal
    private let currency: Locale.Currency

    @State private var value: String = ""
    @State private var active: Bool = false

    @State private var zapMode: Bool = false

    public init(amount: Binding<Decimal>, currency: Locale.Currency) {
        _amount = amount
        self.currency = currency

        let allLocalCurrencies = Locale.availableIdentifiers.compactMap { Locale(identifier: $0) }
        dispalySymbol = allLocalCurrencies.first { $0.currency == currency }?.currencySymbol ?? currency.identifier
    }

    public var body: some View {
        ZStack {
            TextField("", text: $value, onEditingChanged: {
                active = $0

                if !$0 {
                    validate()
                }
            })
            .textFieldStyle(.default)
            #if os(iOS)
                .keyboardType(.decimalPad)
            #endif

            HStack(spacing: 8) {
                Text(value)
                    .lineLimit(1)
                    .headline(.medium)
                    .opacity(0)
                    .padding(.leading, .xSmall)

                Text(dispalySymbol)

                    .onChange(of: currency) { _ in
                        validate()
                    }

                Spacer()
            }
        }
        .onAppear(perform: validate)
        .onChange(of: value) { format(text: $0) }
    }

    private func validate() {
        value = formattedValue
    }

    func format(text: String) {
        if !zapMode, text.last == "." || text.last == "," {
            let stringValue: String = text.components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined()
            let doubleValue: Double = .init((Double(stringValue) ?? 0) * 100.0) ?? 0
            value = formatter.string(for: doubleValue) ?? ""
            value.append(",")
            zapMode = true
        } else if zapMode {
            let stringValue: String = text.components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined()
            let doubleValue: Double = .init((Double(stringValue) ?? 0) / 100.0) ?? 0
            value = formatter.string(for: doubleValue) ?? ""
        } else if text == "0,0" || text == "0.0" {
            value = "0"
            zapMode = false
        } else {
            let doubleValue: Double = .init((text.filter { !$0.isWhitespace })) ?? 0
            value = formatter.string(for: doubleValue) ?? ""
        }
    }

    let dispalySymbol: String
}

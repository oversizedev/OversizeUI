//
// Copyright © 2026 Alexander Romanov
// DateFieldDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

#if os(iOS)
@available(iOS 17.0, *)
struct DateFieldDemo: View {
    @State private var date: Date = .init()
    @State private var optionalDate: Date?

    var body: some View {
        DemoScreen {
            DemoSectionView("Date") {
                DateField("Date", selection: $date)
                    .accessibilityIdentifier("dateField")
            }

            DemoSectionView("Optional date") {
                DateField("Optional date", selection: $optionalDate)
                    .accessibilityIdentifier("optionalDateField")
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    NavigationStack {
        DateFieldDemo()
    }
}
#endif

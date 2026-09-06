//
// Copyright © 2026 Alexander Romanov
// PhoneFieldDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

#if os(iOS)
struct PhoneFieldDemo: View {
    @State private var phone = ""

    var body: some View {
        DemoScreen {
            DemoSectionView("Phone field") {
                PhoneField($phone)
                    .accessibilityIdentifier("phoneField")
            }
        }
    }
}

#Preview {
    NavigationStack {
        PhoneFieldDemo()
    }
}
#endif

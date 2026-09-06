//
// Copyright © 2026 Alexander Romanov
// PremiumLabelTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class PremiumLabelTest: BaseTest {
    override var controlName: String {
        "PremiumLabel"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

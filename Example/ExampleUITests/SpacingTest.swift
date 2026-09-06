//
// Copyright © 2026 Alexander Romanov
// SpacingTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class SpacingTest: BaseTest {
    override var controlName: String {
        "Spacing"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

//
// Copyright © 2026 Alexander Romanov
// SeparatorTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class SeparatorTest: BaseTest {
    override var controlName: String {
        "Separator"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

//
// Copyright © 2026 Alexander Romanov
// LayoutTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class LayoutTest: BaseTest {
    override var controlName: String {
        "Layout"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

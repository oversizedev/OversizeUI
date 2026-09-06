//
// Copyright © 2026 Alexander Romanov
// EmptyStateTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class EmptyStateTest: BaseTest {
    override var controlName: String {
        "EmptyState"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

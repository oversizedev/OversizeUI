//
// Copyright © 2026 Alexander Romanov
// BadgeTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class BadgeTest: BaseTest {
    override var controlName: String {
        "Badge"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

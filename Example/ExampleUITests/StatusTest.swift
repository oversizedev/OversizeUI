//
// Copyright © 2026 Alexander Romanov
// StatusTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class StatusTest: BaseTest {
    override var controlName: String {
        "Status"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

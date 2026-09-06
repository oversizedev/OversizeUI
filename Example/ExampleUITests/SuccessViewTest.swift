//
// Copyright © 2026 Alexander Romanov
// SuccessViewTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class SuccessViewTest: BaseTest {
    override var controlName: String {
        "SuccessView"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

//
// Copyright © 2026 Alexander Romanov
// ErrorViewTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class ErrorViewTest: BaseTest {
    override var controlName: String {
        "ErrorView"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

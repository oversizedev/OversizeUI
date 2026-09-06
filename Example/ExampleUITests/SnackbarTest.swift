//
// Copyright © 2026 Alexander Romanov
// SnackbarTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class SnackbarTest: BaseTest {
    override var controlName: String {
        "Snackbar"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

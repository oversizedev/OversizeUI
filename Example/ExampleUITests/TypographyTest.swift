//
// Copyright © 2026 Alexander Romanov
// TypographyTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class TypographyTest: BaseTest {
    override var controlName: String {
        "Typography"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

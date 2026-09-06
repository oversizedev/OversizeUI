//
// Copyright © 2026 Alexander Romanov
// CoverLayoutTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class CoverLayoutTest: BaseTest {
    override var controlName: String {
        "CoverLayout"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

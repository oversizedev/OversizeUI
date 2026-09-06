//
// Copyright © 2026 Alexander Romanov
// ColorsTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class ColorsTest: BaseTest {
    override var controlName: String {
        "Colors"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

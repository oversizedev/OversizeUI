//
// Copyright © 2026 Alexander Romanov
// GridSelectTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class GridSelectTest: BaseTest {
    override var controlName: String {
        "GridSelect"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

//
// Copyright © 2026 Alexander Romanov
// ElevationTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class ElevationTest: BaseTest {
    override var controlName: String {
        "Elevation"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

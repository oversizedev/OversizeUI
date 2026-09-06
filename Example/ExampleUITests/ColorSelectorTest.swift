//
// Copyright © 2026 Alexander Romanov
// ColorSelectorTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class ColorSelectorTest: BaseTest {
    override var controlName: String {
        "ColorSelector"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

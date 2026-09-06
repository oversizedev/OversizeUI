//
// Copyright © 2026 Alexander Romanov
// IconsTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class IconsTest: BaseTest {
    override var controlName: String {
        "Icons"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

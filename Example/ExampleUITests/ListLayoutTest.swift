//
// Copyright © 2026 Alexander Romanov
// ListLayoutTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class ListLayoutTest: BaseTest {
    override var controlName: String {
        "ListLayout"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

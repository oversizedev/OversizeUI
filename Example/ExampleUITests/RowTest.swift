//
// Copyright © 2026 Alexander Romanov
// RowTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class RowTest: BaseTest {
    override var controlName: String {
        "Row"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

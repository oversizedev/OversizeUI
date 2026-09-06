//
// Copyright © 2026 Alexander Romanov
// ListRowTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class ListRowTest: BaseTest {
    override var controlName: String {
        "ListRow"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

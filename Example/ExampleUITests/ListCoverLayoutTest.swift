//
// Copyright © 2026 Alexander Romanov
// ListCoverLayoutTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class ListCoverLayoutTest: BaseTest {
    override var controlName: String {
        "ListCoverLayout"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

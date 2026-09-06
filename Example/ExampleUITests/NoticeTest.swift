//
// Copyright © 2026 Alexander Romanov
// NoticeTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class NoticeTest: BaseTest {
    override var controlName: String {
        "Notice"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

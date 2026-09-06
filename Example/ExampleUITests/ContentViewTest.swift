//
// Copyright © 2026 Alexander Romanov
// ContentViewTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class ContentViewTest: BaseTest {
    override var controlName: String {
        "ContentView"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

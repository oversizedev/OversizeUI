//
// Copyright © 2026 Alexander Romanov
// StacksTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class StacksTest: BaseTest {
    override var controlName: String {
        "Stacks"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

//
// Copyright © 2026 Alexander Romanov
// AvatarTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class AvatarTest: BaseTest {
    override var controlName: String {
        "Avatar"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

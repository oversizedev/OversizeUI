//
// Copyright © 2026 Alexander Romanov
// TextBoxTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class TextBoxTest: BaseTest {
    override var controlName: String {
        "TextBox"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }
}

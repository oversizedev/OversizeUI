//
// Copyright © 2026 Alexander Romanov
// ButtonTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class ButtonTest: BaseTest {
    override var controlName: String {
        "Buttons"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }

    func testStylesAreRendered() {
        for title in ["Primary", "Secondary", "Tertiary", "Quaternary"] {
            XCTAssertTrue(app.buttons[title].firstMatch.exists, "Missing \(title) button")
        }
    }

    func testButtonIsTappable() {
        let button: XCUIElement = app.buttons["Primary"].firstMatch
        XCTAssertTrue(button.waitForExistence(timeout: 5))
        button.tap()
        XCTAssertTrue(app.navigationBars[controlName].exists)
    }
}

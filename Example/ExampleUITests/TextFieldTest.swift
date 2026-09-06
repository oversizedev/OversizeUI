//
// Copyright © 2026 Alexander Romanov
// TextFieldTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class TextFieldTest: BaseTest {
    override var controlName: String {
        "TextField"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }

    func testAcceptsInput() {
        let field: XCUIElement = app.textFields["nameField"].firstMatch
        guard field.waitForExistence(timeout: 5) else {
            XCTFail("nameField not found")
            return
        }
        field.tap()
        field.typeText("Alexander")
        XCTAssertEqual(field.value as? String, "Alexander")
    }

    func testHelperSwitchesToError() {
        let toggle: XCUIElement = app.buttons["toggleHelperButton"].firstMatch
        guard toggle.waitForExistence(timeout: 5) else {
            XCTFail("toggleHelperButton not found")
            return
        }
        XCTAssertTrue(app.staticTexts["Enter a valid email"].exists)

        toggle.tap()

        XCTAssertTrue(app.staticTexts["Invalid email"].waitForExistence(timeout: 5))
    }
}

//
// Copyright © 2026 Alexander Romanov
// PageIndexTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class PageIndexTest: BaseTest {
    override var controlName: String {
        "PageIndex"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }

    func testAdvancesIndex() {
        let next: XCUIElement = app.buttons["nextPageButton"].firstMatch
        let previous: XCUIElement = app.buttons["previousPageButton"].firstMatch
        XCTAssertTrue(next.waitForExistence(timeout: 5))
        XCTAssertTrue(previous.exists)

        next.tap()
        previous.tap()

        XCTAssertTrue(app.navigationBars[controlName].exists)
    }
}

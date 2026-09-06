//
// Copyright © 2026 Alexander Romanov
// SegmentedControlTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class SegmentedControlTest: BaseTest {
    override var controlName: String {
        "SegmentedControl"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }

    func testSelectsAnotherSegment() {
        let segment: XCUIElement = app.buttons["Two"].firstMatch
        guard segment.waitForExistence(timeout: 5) else {
            XCTFail("Segment Two not found")
            return
        }

        segment.tap()

        XCTAssertTrue(segment.exists)
        XCTAssertTrue(app.navigationBars[controlName].exists)
    }
}

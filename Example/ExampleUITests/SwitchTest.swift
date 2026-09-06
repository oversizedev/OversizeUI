//
// Copyright © 2026 Alexander Romanov
// SwitchTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class SwitchTest: BaseTest {
    override var controlName: String {
        "Switch"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }

    func testTogglesValue() {
        let toggle: XCUIElement = app.switches["trailingSwitch"].firstMatch
        guard toggle.waitForExistence(timeout: 5) else {
            XCTFail("trailingSwitch not found")
            return
        }

        let before: String = toggle.value as? String ?? ""
        toggle.tap()

        let predicate = NSPredicate(format: "value != %@", before)
        let changed = XCTNSPredicateExpectation(predicate: predicate, object: toggle)
        XCTAssertEqual(XCTWaiter.wait(for: [changed], timeout: 5), .completed, "Tapping the switch did not change its value")
    }
}

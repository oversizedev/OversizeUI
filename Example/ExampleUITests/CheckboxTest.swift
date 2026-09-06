//
// Copyright © 2026 Alexander Romanov
// CheckboxTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class CheckboxTest: BaseTest {
    override var controlName: String {
        "Checkbox"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }

    func testTogglesValue() {
        let checkbox: XCUIElement = app.buttons["leadingCheckbox"].firstMatch
        guard checkbox.waitForExistence(timeout: 5) else {
            XCTFail("leadingCheckbox not found")
            return
        }

        let before: Bool = checkbox.isSelected
        checkbox.tap()

        let predicate = NSPredicate(format: "isSelected == %@", NSNumber(value: !before))
        let changed = XCTNSPredicateExpectation(predicate: predicate, object: checkbox)
        XCTAssertEqual(XCTWaiter.wait(for: [changed], timeout: 5), .completed, "Tapping the checkbox did not change its selected state")
    }

    func testDisabledCheckboxIsNotEnabled() {
        let disabled: XCUIElement = app.buttons["Disabled on"].firstMatch
        XCTAssertTrue(disabled.waitForExistence(timeout: 5))
        XCTAssertFalse(disabled.isEnabled)
    }
}

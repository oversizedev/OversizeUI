//
// Copyright © 2026 Alexander Romanov
// RadioTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class RadioTest: BaseTest {
    override var controlName: String {
        "Radio"
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars[controlName].waitForExistence(timeout: 5))
    }

    func testPickerSelectsAnotherOption() {
        let option: XCUIElement = app.buttons["Three"].firstMatch
        guard option.waitForExistence(timeout: 5) else {
            XCTFail("Option Three not found in the radio picker")
            return
        }
        XCTAssertFalse(option.isSelected, "Three should not be selected initially")

        option.tap()

        let predicate = NSPredicate(format: "isSelected == YES")
        let selected = XCTNSPredicateExpectation(predicate: predicate, object: option)
        XCTAssertEqual(XCTWaiter.wait(for: [selected], timeout: 5), .completed, "Tapping an option did not select it")
    }
}

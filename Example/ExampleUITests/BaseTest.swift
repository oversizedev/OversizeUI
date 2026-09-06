//
// Copyright © 2026 Alexander Romanov
// BaseTest.swift, created on 06.09.2026
//

import XCTest

/// Launches the demo app and navigates to the screen named by ``controlName``.
///
/// The name is the single contract between the tests and the app: `Demos.swift`
/// uses it for the list entry and for the screen's navigation title.
@MainActor
class BaseTest: XCTestCase {
    lazy var app: XCUIApplication = .init()

    /// Must be overridden with the demo title from `Demos.swift`.
    var controlName: String {
        "Base"
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
        XCTAssertTrue(app.navigationBars["OversizeUI"].waitForExistence(timeout: 20), "The app did not reach the component list")
        try openControlPage()
    }

    private func openControlPage() throws {
        let entry: XCUIElement = app.buttons[controlName].firstMatch

        // Entries live in a lazy stack, so an off-screen one does not exist yet.
        var swipes = 0
        while !entry.exists || !entry.isHittable {
            guard swipes < 20 else {
                XCTFail("No entry named \(controlName) in the component list")
                return
            }
            app.swipeUp()
            swipes += 1
        }

        entry.tap()
    }
}

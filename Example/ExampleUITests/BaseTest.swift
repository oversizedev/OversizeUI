//
// Copyright © 2026 Alexander Romanov
// BaseTest.swift, created on 06.09.2026
//

import XCTest

/// Launches the demo app straight onto the screen named by ``controlName``.
///
/// The name is the single contract between the tests and the app: `Demos.swift`
/// uses it for the list entry and for the screen's navigation title, and the app
/// resolves it from a launch argument so tests do not have to walk the list.
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
        app.launchArguments += ["-uiTestDemo", controlName]
        app.launch()
        XCTAssertTrue(
            app.navigationBars[controlName].waitForExistence(timeout: 30),
            "The app did not open the \(controlName) screen"
        )
    }
}

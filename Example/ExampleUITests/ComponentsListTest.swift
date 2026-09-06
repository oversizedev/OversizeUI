//
// Copyright © 2026 Alexander Romanov
// ComponentsListTest.swift, created on 06.09.2026
//

import XCTest

@MainActor
final class ComponentsListTest: XCTestCase {
    private lazy var app: XCUIApplication = .init()

    /// Section titles rendered by `Demos.sections`.
    private let sectionTitles = ["Layouts", "Controls", "Toggles", "Fields", "Feedback", "Design System"]

    /// A representative demo from each section, by `Demos.swift` title.
    private let demoTitles = ["Layout", "Buttons", "Checkbox", "TextField", "Notice", "Colors"]

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
    }

    func testLaunch() {
        XCTAssertTrue(app.navigationBars["OversizeUI"].waitForExistence(timeout: 10))
    }

    func testSectionsExist() {
        for title in sectionTitles {
            let section: XCUIElement = app.staticTexts[title].firstMatch
            section.scrollIntoView(in: app)
            XCTAssertTrue(section.exists, "Missing section \(title)")
        }
    }

    func testDemoEntriesExist() {
        for title in demoTitles {
            let entry: XCUIElement = app.buttons[title].firstMatch
            entry.scrollIntoView(in: app)
            XCTAssertTrue(entry.exists, "Missing demo entry \(title)")
        }
    }

    func testNavigatesBackToList() {
        let entry: XCUIElement = app.buttons["Buttons"].firstMatch
        XCTAssertTrue(entry.waitForExistence(timeout: 10))
        entry.scrollIntoViewAndTap(in: app)

        XCTAssertTrue(app.navigationBars["Buttons"].waitForExistence(timeout: 5))

        app.navigationBars.buttons.firstMatch.tap()

        XCTAssertTrue(app.navigationBars["OversizeUI"].waitForExistence(timeout: 5))
    }
}

private extension XCUIElement {
    func scrollIntoView(in app: XCUIApplication, maxSwipes: Int = 12) {
        var swipes = 0
        while !isHittable, swipes < maxSwipes {
            app.scrollViews.firstMatch.swipeUp()
            swipes += 1
        }
    }
}

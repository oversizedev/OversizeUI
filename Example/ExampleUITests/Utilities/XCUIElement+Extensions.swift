//
// Copyright © 2026 Alexander Romanov
// XCUIElement+Extensions.swift, created on 06.09.2026
//

import XCTest

extension XCUIElement {
    func clearText() {
        tap()
        let currentText = value as? String ?? ""
        typeText(String(repeating: XCUIKeyboardKey.delete.rawValue, count: currentText.count))
    }

    /// Scrolls the first scroll view of `app` until the element is hittable, then taps it.
    func scrollIntoViewAndTap(in app: XCUIApplication, maxSwipes: Int = 10) {
        var swipes = 0
        while !isHittable, swipes < maxSwipes {
            app.scrollViews.firstMatch.swipeUp()
            swipes += 1
        }
        tap()
    }

    @discardableResult
    func waitToAppear(timeout: TimeInterval = 5) -> Bool {
        waitForExistence(timeout: timeout)
    }
}

//
// Copyright © 2026 Alexander Romanov
// UITestSupport.swift, created on 06.09.2026
//

import Foundation

enum UITestSupport {
    /// Launch argument used by the UI tests to open a demo screen directly.
    ///
    /// Walking the component list by swiping costs a full accessibility snapshot per step, which is
    /// slow and times out on screens near the bottom of the list.
    static let demoArgument = "-uiTestDemo"

    static var requestedDemoTitle: String? {
        let arguments = ProcessInfo.processInfo.arguments
        guard let index = arguments.firstIndex(of: demoArgument), arguments.indices.contains(index + 1) else {
            return nil
        }
        return arguments[index + 1]
    }
}

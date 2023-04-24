//
//  _9_03_APIx2_Users_and_TodosUITestsLaunchTests.swift
//  09.03 APIx2 Users and TodosUITests
//
//  Created by Max Christopher Romslo Schulstock on 09/03/2023.
//

import XCTest

final class _9_03_APIx2_Users_and_TodosUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}

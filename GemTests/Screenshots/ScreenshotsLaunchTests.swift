// Copyright (c). Gem Wallet. All rights reserved.

import XCTest
import Primitives

final class ScreenshotsLaunchTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor func testScreenshots() {
        // Take a screenshot of an app's first window.
        let app = XCUIApplication()
        app.launch()
        let snapshoter = Snapshoter(app: app)

        let collectionViewsQuery = app.collectionViews

        // import wallet if not already
        if app.buttons.containing(.button, identifier: "welcome_import").count > 0 {

            app.buttons.element(boundBy: 1).tap()

            collectionViewsQuery.buttons.element(matching: .button, identifier: "multicoin").tap()
            
            let secretPhrase = ProcessInfo.processInfo.environment["SCREENSHOTS_SECRET_PHRASE"]!
            collectionViewsQuery.textViews.element(matching: .textView, identifier: "phrase")
                .typeText(secretPhrase)

            app.buttons.element(matching: .button, identifier: "import_wallet").tap()
        }

        sleep(4)

        snapshoter.snap("0_secure")

        collectionViewsQuery.staticTexts["Solana"].tap()

        snapshoter.snap("1_private")

        collectionViewsQuery.buttons.element(matching: .button, identifier: "buy").tap()

        sleep(4)

        snapshoter.snap("7_buy")

        app.navigationBars.buttons.element(boundBy: 0).tap()

        collectionViewsQuery.buttons.element(matching: .button, identifier: "price").tap()

        sleep(1)

        snapshoter.snap("3_market")

        app.navigationBars.buttons.element(boundBy: 0).tap()

        collectionViewsQuery.buttons.element(matching: .button, identifier: "stake").tap()
        
        sleep(12)

        snapshoter.snap("6_earn")

        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()

        collectionViewsQuery.buttons.element(matching: .button, identifier: "manage").tap()

        snapshoter.snap("2_powerful")

        app.navigationBars.buttons.element(boundBy: 0).tap()

        sleep(1)

        app.tabBars.buttons.element(boundBy: 1).tap()

        snapshoter.snap("4_transactions")

        app.tabBars.buttons.element(boundBy: 2).tap()

        snapshoter.snap("5_settings")
    }
}

struct Snapshoter {

    let app: XCUIApplication
    let timeout: UInt32 = 1

    func snap(_ name: String) {
        sleep(timeout)

        let screenshotData = app.windows.firstMatch.screenshot().pngRepresentation

        let path = ProcessInfo.processInfo.environment["SCREENSHOTS_PATH"]!
        let directoryPath = "\(path)/\(Locale.current.appstoreLanguageIdentifier())"
        
        let fileURL = URL(fileURLWithPath: "\(directoryPath)/\(UIDevice.current.model.lowercased())_\(name).png")

        // Create the directory if it doesn't exist
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: directoryPath) {
            try! fileManager.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
        }

        // Save the screenshot
        try! screenshotData.write(to: fileURL)
    }
}

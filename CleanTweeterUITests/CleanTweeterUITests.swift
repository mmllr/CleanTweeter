
import XCTest

class CleanTweeterUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
 
        continueAfterFailure = false

        XCUIApplication().launch()

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNewPost() {
		let app = XCUIApplication()
		app.navigationBars["Clean Tweeter"].buttons["New Post"].tap()
		
		let tweettextfieldTextView = app.textViews["TweetTextField"]
		tweettextfieldTextView.typeText("Mein lieber Herr Gesangsverein")

		app.navigationBars["Tim Cook"].buttons["Done"].tap()

		XCTAssertTrue(app.staticTexts["Mein lieber Herr Gesangsverein"].exists)
    }

}


import XCTest
@testable import CleanTweeter

class ViewSpy : NewPostView {
	var viewModel: NewPostViewModel?

	func updateView(_ viewModel: NewPostViewModel) {
		self.viewModel = viewModel
	}

}

class InteractorSpy : NewPostInteractorInput {
	var requestedUser: String?
	var postedContent: String?
	var postedDate: Date?
	var postedUser: String?

	func requestAvatarForUserName(_ userName: String) {
		requestedUser = userName
	}
	
	func postContent(_ content: String, forUser: String, publicationDate: Date) {
		postedDate = publicationDate
		postedUser = forUser
		postedContent = content
	}
}

class NewPostPresenterTests: XCTestCase {
	var sut: NewPostPresenter!
	var viewSpy = ViewSpy()
	var interactorSpy = InteractorSpy()
	
    override func setUp() {
        super.setUp()
		sut = NewPostPresenter(factory: MobileResourceFactory(), userName: "user")
		sut.view = viewSpy
    }

    override func tearDown() {
        super.tearDown()
    }

	func expectedCharacterCountStringForContentString(_ contentString: String) -> String {
		let counter = 160 - min(contentString.characters.count, 160)
		return "\(counter)"
	}

	func expectedAttributedContentStringForContent(_ content: String, withHighlightingColor: UIColor) -> NSAttributedString {
		return content.findRangesWithPattern("((@|#)([A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)_]+))|(http(s)?://([A-Z0-9a-z._-]*(/)?)*)").reduce(NSMutableAttributedString(string: content)) {
			let string = $0
			let length = content.characters.distance(from: $1.lowerBound, to: $1.upperBound)
			let range = NSMakeRange(content.characters.distance(from: content.startIndex, to: $1.lowerBound), length)
			string.addAttribute(NSForegroundColorAttributeName, value: withHighlightingColor, range: range)
			return string
		}
	}

	func testThatRequestingTheViewModelWillAksTheInteractorForTheAvatar() {
		sut.interactor = self.interactorSpy

		sut.requestViewForContent("long content")

		XCTAssertEqual(interactorSpy.requestedUser, "user")
		XCTAssertEqual(viewSpy.viewModel, NewPostViewModel(name: "user", avatar: "placeholder", content: NSAttributedString(string: "long content"), characterCount: expectedCharacterCountStringForContentString("long content"), canEdit: true, canPost: true))
	}

	func testThatReceivingAnAvatarWillUpdateTheViewModel() {
		sut.requestViewForContent("content")
	
		sut.foundAvatar("avatar")

		XCTAssertEqual(viewSpy.viewModel, NewPostViewModel(name: "user", avatar: "avatar", content: NSAttributedString(string: "content"), characterCount: expectedCharacterCountStringForContentString("content"), canEdit: true, canPost: true))
	}

	func testThatAContentStringWithLessThan160CharactersIsInTheViewModelsContentAndEditable() {
		let longString = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores"

		for characterCount in 0...159 {
			let substring = longString.substring(to: longString.characters.index(longString.startIndex, offsetBy: characterCount))

			sut.requestViewForContent(substring)

			XCTAssertEqual(viewSpy.viewModel, NewPostViewModel(name: "user", avatar: "placeholder", content: NSAttributedString(string: substring), characterCount: expectedCharacterCountStringForContentString(substring), canEdit: true, canPost: characterCount > 0))
		}
	}

	func testThatAContentStringWithMore160CharactersIsInTheViewModelsContentAndEditable() {
		let longString = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores"

		let expectedContentString = longString.substring(to: longString.characters.index(longString.startIndex, offsetBy: 160))

		for characterCount in 160...longString.characters.count {
			let substring = longString.substring(to: longString.characters.index(longString.startIndex, offsetBy: characterCount))
			
			sut.requestViewForContent(substring)
			
			XCTAssertEqual(viewSpy.viewModel, NewPostViewModel(name: "user", avatar: "placeholder", content: NSAttributedString(string: expectedContentString), characterCount: expectedCharacterCountStringForContentString(substring), canEdit: false, canPost: true))
		}
	}

	func testThatKeywordsInTweetsWillBeHighlighted() {
		let content = "@mention plain text #tag"
		
		sut.requestViewForContent(content)

		XCTAssertEqual(viewSpy.viewModel!.content, expectedAttributedContentStringForContent(content, withHighlightingColor: UIColor.blue))
	}

	func testThatEmptyContentWillResultInAFalseCanPostViewModel() {
		sut.requestViewForContent("")

		XCTAssertFalse(viewSpy.viewModel!.canPost)
	}

	func testThatPostingWillInvokeTheInteractor() {
		sut.interactor = self.interactorSpy
		sut.requestViewForContent("New content")

		sut.post()

		XCTAssertEqual(self.interactorSpy.postedContent, "New content")
		XCTAssertEqual(self.interactorSpy.postedUser, "user")
		XCTAssertEqualWithAccuracy((self.interactorSpy.postedDate?.timeIntervalSinceNow)!, TimeInterval(0), accuracy: 0.1)
	}
}

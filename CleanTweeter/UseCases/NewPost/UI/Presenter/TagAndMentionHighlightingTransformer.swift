
import UIKit

class TagAndMentionHighlightingTransformer : NSValueTransformer {
	let resourceFactory: ResourceFactory

	init(factory: ResourceFactory) {
		self.resourceFactory = factory
		super.init()
	}
	override class func transformedValueClass() -> AnyClass {
		return NSAttributedString.self
	}

	override class func allowsReverseTransformation() -> Bool {
		return false
	}

	override func transformedValue(value: AnyObject?) -> AnyObject? {
		guard let transformedValue = value as! String? else {
			return nil
		}
		return transformedValue.findRangesWithPattern("((@|#)([A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)_]+))|(http(s)?://([A-Z0-9a-z._-]*(/)?)*)").reduce(NSMutableAttributedString(string: transformedValue)) {
			let string = $0
			let range = NSMakeRange(transformedValue.startIndex.distanceTo($1.startIndex), $1.count)
			string.addAttribute(self.resourceFactory.highlightingAttribute.0, value: self.resourceFactory.highlightingAttribute.1, range: range)
			return string
		}
	}
}

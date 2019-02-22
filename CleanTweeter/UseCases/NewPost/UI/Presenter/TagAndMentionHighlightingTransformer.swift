
import Foundation

class TagAndMentionHighlightingTransformer : ValueTransformer {
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

	override func transformedValue(_ value: Any?) -> Any? {
		guard let transformedValue = value as! String? else {
			return nil
		}
		return transformedValue.findRangesWithPattern("((@|#)([A-Z0-9a-z(é|ë|ê|è|à|â|ä|á|ù|ü|û|ú|ì|ï|î|í)_]+))|(http(s)?://([A-Z0-9a-z._-]*(/)?)*)").reduce(NSMutableAttributedString(string: transformedValue)) {
			let string = $0
			let length = transformedValue.distance(from: $1.lowerBound, to: $1.upperBound)
			let range = NSMakeRange(transformedValue.distance(from: transformedValue.startIndex, to: $1.lowerBound), length)
			string.addAttribute(resourceFactory.highlightingAttribute.0, value: self.resourceFactory.highlightingAttribute.1, range: range)
			return string
		}
	}
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKey(_ input: String) -> NSAttributedString.Key {
	return NSAttributedString.Key(rawValue: input)
}

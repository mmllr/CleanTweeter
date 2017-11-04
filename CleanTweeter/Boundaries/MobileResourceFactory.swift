
import Foundation
import UIKit

class MobileResourceFactory : ResourceFactory {
	var highlightingAttribute: (String, AnyObject)

	init() {
		highlightingAttribute = (NSAttributedStringKey.foregroundColor.rawValue, UIColor.blue)
	}
}

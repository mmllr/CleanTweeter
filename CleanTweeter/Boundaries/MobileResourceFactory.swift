
import Foundation
import UIKit

class MobileResourceFactory : ResourceFactory {
	var highlightingAttribute: (NSAttributedString.Key, AnyObject)

	init() {
		highlightingAttribute = (NSAttributedString.Key.foregroundColor, UIColor.blue)
	}
}

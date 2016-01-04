
import Foundation
import UIKit

class MobileResourceFactory : ResourceFactory {
	var highlightingAttribute: (String, AnyObject)

	init() {
		highlightingAttribute = (NSForegroundColorAttributeName, UIColor.blueColor())
	}
}

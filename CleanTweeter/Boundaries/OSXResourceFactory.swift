
import Foundation
import Cocoa

class OSXResourceFactory : ResourceFactory {
	var highlightingAttribute: (String, AnyObject)
	
	init() {
		highlightingAttribute = (NSForegroundColorAttributeName, NSColor.blueColor())
	}
}

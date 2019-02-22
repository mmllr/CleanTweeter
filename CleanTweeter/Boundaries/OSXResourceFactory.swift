
import Foundation
import Cocoa

class OSXResourceFactory : ResourceFactory {
	var highlightingAttribute: (NSAttributedString.Key, AnyObject)
	
	init() {
		highlightingAttribute = (NSAttributedString.Key.foregroundColor as NSAttributedString.Key, NSColor.blue)
	}
}

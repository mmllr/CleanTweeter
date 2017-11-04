
import Foundation

extension String {
	func findRangesWithPattern(_ pattern: String) -> [Range<String.Index>] {
		do {
			let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
			return regex.matches(in: self, options: .reportCompletion, range: NSMakeRange(0, self.count)).map {
				let start = index(startIndex, offsetBy: $0.range.location)
				let end = index(startIndex, offsetBy: NSMaxRange($0.range))
				return (start ..< end)
			}
		} catch _ {
			return []
		}
	}
}

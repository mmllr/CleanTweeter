
import Foundation

func createUsers() -> [User] {
	let dateFormatter = DateFormatter()
	dateFormatter.timeStyle = .none
	dateFormatter.dateStyle = .full
	dateFormatter.dateFormat = "yyyy.MM.dd"

	let users = [
		User(name: "Tim Cook", followedUsers: ["Jony Ive", "Craig Federighi", "Eddy Cue"], tweets: [
			Tweet(author: "Tim Cook", content: "Super awesome!", publicationDate: dateFormatter.date(from: "2014.09.12")!),
			Tweet(author: "Tim Cook", content: "Incredible!", publicationDate: dateFormatter.date(from: "2014.11.3")!),
			Tweet(author: "Tim Cook", content: "Only #Apple can do this!", publicationDate: dateFormatter.date(from: "2014.11.2")!)
			], avatar: "https://images.apple.com/leadership/overview/executiveprofiles/ceo/image_large_2x.jpg"),
		User(name: "Craig Federighi", followedUsers: ["Tim Cook", "Jony Ive"], tweets: [
			Tweet(author: "Craig Federighi", content: "Forever #hairforceone", publicationDate: dateFormatter.date(from: "2014.10.29")!),
			Tweet(author: "Craig Federighi", content: "@Jony leather UI?", publicationDate:dateFormatter.date(from: "2014.11.1")!)
			], avatar: "https://images.apple.com/leadership/overview/executiveprofiles/srvpsoftwareengineering/image_large_2x.jpg"),
		User(name: "Jony Ive", followedUsers: ["Tim Cook"], tweets: [
			Tweet(author: "Jony Ive", content: "Aluminum!", publicationDate: dateFormatter.date(from: "2014.10.30")!),
			Tweet(author: "Jony Ive", content: "Sire!", publicationDate: dateFormatter.date(from: "2014.11.1")!),
			], avatar: "https://images.apple.com/leadership/overview/executiveprofiles/chiefdesignofficer/image_large_2x.jpg"),
		User(name: "Eddy Cue", followedUsers: ["Tim Cook", "Jony Ive", "Craig Federighi"], tweets: [
			Tweet(author: "Eddy Cue", content: "Lets change the #iTunes UI", publicationDate: dateFormatter.date(from: "2014.08.3")!),
			Tweet(author: "Eddy Cue", content: "AppleTV #FTW!", publicationDate: dateFormatter.date(from: "2012.10.3")!),
			], avatar: "https://images.apple.com/leadership/overview/executiveprofiles/srvpinternetsoftwareandservices/image_large_2x.jpg")
	]
	return users
}

class DemoUserRepository : UserRepository {
	var store: Dictionary<String, User> = [:]

	init() {
		for user in createUsers() {
			updateUser(user)
		}
	}

	func findUser(_ userName: String) -> User? {
		return store[userName]
	}

	func updateUser(_ user: User) {
		store[user.name] = user
	}
}

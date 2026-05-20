import Foundation

struct Character: Identifiable, Codable {
    let id: String
    let name: String
    let avatar: String
    let color: String
    let bio: String
    var affinity: Int
    var unlockedNodeIDs: Set<String>
    var currentNodeID: String
    var messages: [ChatMessage]
    var hasUnread: Bool

    init(id: String, name: String, avatar: String, color: String, bio: String, startNodeID: String) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.color = color
        self.bio = bio
        self.affinity = 0
        self.unlockedNodeIDs = []
        self.currentNodeID = startNodeID
        self.messages = []
        self.hasUnread = true
    }

    var lastMessagePreview: String {
        messages.last?.text ?? "Tap to start chatting..."
    }
}

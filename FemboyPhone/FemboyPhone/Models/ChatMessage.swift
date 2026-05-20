import Foundation

struct ChatMessage: Identifiable, Codable {
    let id: UUID
    let text: String
    let sender: Sender
    let timestamp: Date

    enum Sender: String, Codable {
        case character
        case player
        case system
    }

    init(text: String, sender: Sender, timestamp: Date = Date()) {
        self.id = UUID()
        self.text = text
        self.sender = sender
        self.timestamp = timestamp
    }
}

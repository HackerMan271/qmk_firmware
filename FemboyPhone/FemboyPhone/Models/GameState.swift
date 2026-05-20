import Foundation
import SwiftUI
import Combine

enum AppScreen: Equatable {
    case home
    case messages
    case chat(characterID: String)
}

class GameState: ObservableObject {
    @Published var characters: [Character]
    @Published var screen: AppScreen = .home
    @Published var pendingLines: [String] = []
    @Published var awaitingChoices: [DialogueChoice] = []
    @Published var isTyping: Bool = false

    private var typingTask: Task<Void, Never>?

    init() {
        self.characters = [
            Character(id: "riley", name: "Riley", avatar: "🎮", color: "pink",
                      bio: "Diamond Valorant player, streaming queen, chaotic good ✨", startNodeID: "start"),
            Character(id: "kai",   name: "Kai",   avatar: "🖊️", color: "purple",
                      bio: "Watercolor artist, soft vibes, very shy 🌿",           startNodeID: "start"),
            Character(id: "ash",   name: "Ash",   avatar: "💅", color: "blue",
                      bio: "Fashion obsessed, confident, impeccable taste 💙",      startNodeID: "start"),
        ]
    }

    var currentCharacter: Character? {
        guard case .chat(let id) = screen else { return nil }
        return characters.first(where: { $0.id == id })
    }

    func index(of id: String) -> Int? {
        characters.firstIndex(where: { $0.id == id })
    }

    // MARK: – Navigation
    func openChat(characterID: String) {
        if let idx = index(of: characterID) {
            characters[idx].hasUnread = false
        }
        screen = .chat(characterID: characterID)
        if let idx = index(of: characterID), characters[idx].messages.isEmpty {
            advanceDialogue(characterID: characterID)
        }
    }

    func goBack() {
        typingTask?.cancel()
        typingTask = nil
        isTyping = false
        pendingLines = []
        awaitingChoices = []
        if case .chat = screen {
            screen = .messages
        } else {
            screen = .home
        }
    }

    // MARK: – Dialogue engine
    func advanceDialogue(characterID: String) {
        guard let idx = index(of: characterID) else { return }
        let charID = characters[idx].id
        guard let tree = allDialogueTrees[charID] else { return }
        let nodeID = characters[idx].currentNodeID
        guard let node = tree.node(for: nodeID) else { return }

        awaitingChoices = []
        isTyping = true

        typingTask = Task { @MainActor in
            for line in node.lines {
                guard !Task.isCancelled else { return }
                try? await Task.sleep(nanoseconds: 700_000_000)
                guard !Task.isCancelled else { return }
                if let i = self.index(of: charID) {
                    self.characters[i].messages.append(
                        ChatMessage(text: line, sender: .character)
                    )
                    self.characters[i].hasUnread = !(self.screen == .chat(characterID: charID))
                }
            }
            guard !Task.isCancelled else { return }
            self.isTyping = false
            if let i = self.index(of: charID) {
                self.characters[i].affinity += node.affinityDelta
            }
            if !node.choices.isEmpty {
                self.awaitingChoices = node.choices
            } else if let next = node.autoNext {
                if let i = self.index(of: charID) {
                    self.characters[i].currentNodeID = next
                }
                self.advanceDialogue(characterID: charID)
            }
        }
    }

    func selectChoice(_ choice: DialogueChoice, characterID: String) {
        guard let idx = index(of: characterID) else { return }
        characters[idx].messages.append(
            ChatMessage(text: choice.text, sender: .player)
        )
        characters[idx].affinity += choice.affinityDelta
        characters[idx].currentNodeID = choice.nextNodeID
        awaitingChoices = []
        advanceDialogue(characterID: characterID)
    }

    // MARK: – Affinity helpers
    func affinityLabel(for character: Character) -> String {
        switch character.affinity {
        case ..<0:   return "Awkward"
        case 0...2:  return "Strangers"
        case 3...5:  return "Acquaintances"
        case 6...9:  return "Friends"
        case 10...14: return "Close"
        default:     return "Besties 💕"
        }
    }

    func characterColor(for id: String) -> Color {
        switch characters.first(where: { $0.id == id })?.color {
        case "pink":   return Color(red: 1.0, green: 0.45, blue: 0.65)
        case "purple": return Color(red: 0.65, green: 0.45, blue: 1.0)
        case "blue":   return Color(red: 0.3, green: 0.65, blue: 1.0)
        default:       return .white
        }
    }
}

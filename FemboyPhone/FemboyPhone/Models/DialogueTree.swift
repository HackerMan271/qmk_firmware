import Foundation

struct DialogueNode: Identifiable {
    let id: String
    let lines: [String]
    let choices: [DialogueChoice]
    let autoNext: String?
    let affinityDelta: Int

    init(id: String, lines: [String], choices: [DialogueChoice] = [], autoNext: String? = nil, affinityDelta: Int = 0) {
        self.id = id
        self.lines = lines
        self.choices = choices
        self.autoNext = autoNext
        self.affinityDelta = affinityDelta
    }
}

struct DialogueChoice: Identifiable {
    let id: String
    let text: String
    let nextNodeID: String
    let affinityDelta: Int

    init(id: String, text: String, nextNodeID: String, affinityDelta: Int = 0) {
        self.id = id
        self.text = text
        self.nextNodeID = nextNodeID
        self.affinityDelta = affinityDelta
    }
}

struct DialogueTree {
    let nodes: [String: DialogueNode]
    let startNodeID: String

    func node(for id: String) -> DialogueNode? {
        nodes[id]
    }
}

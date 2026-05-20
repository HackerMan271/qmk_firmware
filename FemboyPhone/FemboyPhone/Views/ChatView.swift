import SwiftUI

struct ChatView: View {
    @EnvironmentObject var state: GameState
    let characterID: String

    private var character: Character? {
        state.characters.first(where: { $0.id == characterID })
    }

    var body: some View {
        ZStack {
            Color(red: 0.06, green: 0.06, blue: 0.10)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Nav bar
                HStack(spacing: 10) {
                    Button { state.goBack() } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.blue)
                    }

                    if let c = character {
                        ZStack {
                            Circle()
                                .fill(state.characterColor(for: c.id).opacity(0.7))
                                .frame(width: 36, height: 36)
                            Text(c.avatar)
                                .font(.system(size: 18))
                        }
                        VStack(alignment: .leading, spacing: 0) {
                            Text(c.name)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                            Text(state.affinityLabel(for: c))
                                .font(.system(size: 11))
                                .foregroundColor(state.characterColor(for: c.id))
                        }
                    }
                    Spacer()
                    Image(systemName: "video")
                        .font(.system(size: 17))
                        .foregroundColor(.blue)
                    Image(systemName: "phone")
                        .font(.system(size: 17))
                        .foregroundColor(.blue)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color(red: 0.08, green: 0.08, blue: 0.13))

                Divider().background(Color(white: 0.2))

                // Messages
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 2) {
                            if let c = character {
                                ForEach(c.messages) { message in
                                    MessageBubble(message: message, character: c)
                                        .id(message.id)
                                }

                                if state.isTyping {
                                    TypingIndicator(character: c)
                                        .id("typing")
                                }

                                // Spacer so choices don't overlap messages
                                Color.clear.frame(height: 8).id("bottom")
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .onChange(of: character?.messages.count) { _ in
                        withAnimation(.easeOut(duration: 0.3)) {
                            proxy.scrollTo("bottom", anchor: .bottom)
                        }
                    }
                    .onChange(of: state.isTyping) { _ in
                        withAnimation {
                            proxy.scrollTo("bottom", anchor: .bottom)
                        }
                    }
                }

                // Choice buttons
                if !state.awaitingChoices.isEmpty {
                    ChoicePanel(choices: state.awaitingChoices, characterID: characterID)
                } else if let c = character, !c.messages.isEmpty, !state.isTyping,
                          state.awaitingChoices.isEmpty,
                          allDialogueTrees[c.id]?.node(for: c.currentNodeID)?.autoNext == nil,
                          allDialogueTrees[c.id]?.node(for: c.currentNodeID)?.choices.isEmpty == true {
                    // Conversation ended
                    VStack(spacing: 6) {
                        Text("✨ End of chapter ✨")
                            .font(.system(size: 13))
                            .foregroundColor(Color(white: 0.5))
                            .padding(.vertical, 10)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.08, green: 0.08, blue: 0.13))
                }
            }
        }
    }
}

// MARK: – Message bubble
struct MessageBubble: View {
    @EnvironmentObject var state: GameState
    let message: ChatMessage
    let character: Character

    var body: some View {
        HStack {
            if message.sender == .player { Spacer(minLength: 60) }

            Text(message.text)
                .font(.system(size: 15))
                .foregroundColor(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 9)
                .background(bubbleColor, in: bubbleShape)

            if message.sender == .character { Spacer(minLength: 60) }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 2)
    }

    var bubbleColor: Color {
        switch message.sender {
        case .player:    return Color(red: 0.0, green: 0.47, blue: 1.0)
        case .character: return state.characterColor(for: character.id).opacity(0.25)
        case .system:    return .clear
        }
    }

    var bubbleShape: some Shape {
        RoundedRectangle(cornerRadius: 18)
    }
}

// MARK: – Typing indicator
struct TypingIndicator: View {
    @EnvironmentObject var state: GameState
    let character: Character
    @State private var phase = 0

    var body: some View {
        HStack {
            HStack(spacing: 4) {
                ForEach(0..<3) { i in
                    Circle()
                        .fill(state.characterColor(for: character.id))
                        .frame(width: 7, height: 7)
                        .opacity(phase == i ? 1.0 : 0.3)
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 11)
            .background(
                state.characterColor(for: character.id).opacity(0.2),
                in: RoundedRectangle(cornerRadius: 18)
            )
            Spacer(minLength: 60)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 2)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { t in
                withAnimation(.easeInOut(duration: 0.3)) {
                    phase = (phase + 1) % 3
                }
            }
        }
    }
}

// MARK: – Choice panel
struct ChoicePanel: View {
    @EnvironmentObject var state: GameState
    let choices: [DialogueChoice]
    let characterID: String

    var body: some View {
        VStack(spacing: 8) {
            ForEach(choices) { choice in
                Button {
                    state.selectChoice(choice, characterID: characterID)
                } label: {
                    Text(choice.text)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 11)
                        .background(
                            Color(red: 0.14, green: 0.14, blue: 0.20),
                            in: RoundedRectangle(cornerRadius: 12)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(Color(white: 0.25), lineWidth: 0.5)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color(red: 0.08, green: 0.08, blue: 0.13))
    }
}

import SwiftUI

struct MessagesListView: View {
    @EnvironmentObject var state: GameState

    var body: some View {
        ZStack {
            Color(red: 0.06, green: 0.06, blue: 0.10)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Nav bar
                HStack {
                    Button {
                        state.goBack()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                            Text("Back")
                                .font(.system(size: 16))
                        }
                        .foregroundColor(.blue)
                    }
                    Spacer()
                    Text("Messages")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 17))
                        .foregroundColor(.blue)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(red: 0.08, green: 0.08, blue: 0.13))

                Divider()
                    .background(Color(white: 0.2))

                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(white: 0.5))
                    Text("Search")
                        .foregroundColor(Color(white: 0.4))
                    Spacer()
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 9)
                .background(Color(white: 0.14), in: RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)

                // Conversation list
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(state.characters) { character in
                            ConversationRow(character: character)
                                .onTapGesture {
                                    state.openChat(characterID: character.id)
                                }
                            Divider()
                                .background(Color(white: 0.15))
                                .padding(.leading, 76)
                        }
                    }
                }
            }
        }
    }
}

struct ConversationRow: View {
    @EnvironmentObject var state: GameState
    let character: Character

    var body: some View {
        HStack(spacing: 14) {
            // Avatar
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                state.characterColor(for: character.id).opacity(0.8),
                                state.characterColor(for: character.id).opacity(0.4),
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 52, height: 52)
                Text(character.avatar)
                    .font(.system(size: 26))
            }

            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text(character.name)
                        .font(.system(size: 16, weight: character.hasUnread ? .bold : .regular))
                        .foregroundColor(.white)
                    Spacer()
                    Text("now")
                        .font(.system(size: 12))
                        .foregroundColor(Color(white: 0.5))
                }
                Text(character.lastMessagePreview)
                    .font(.system(size: 14))
                    .foregroundColor(character.hasUnread ? Color(white: 0.85) : Color(white: 0.45))
                    .lineLimit(1)
            }

            if character.hasUnread {
                Circle()
                    .fill(Color(red: 0.2, green: 0.6, blue: 1.0))
                    .frame(width: 10, height: 10)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .contentShape(Rectangle())
    }
}

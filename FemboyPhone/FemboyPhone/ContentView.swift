import SwiftUI

struct ContentView: View {
    @EnvironmentObject var state: GameState

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            GeometryReader { geo in
                let scale = min(geo.size.width / 375, geo.size.height / 780)
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        PhoneFrameView {
                            screenContent
                        }
                        .scaleEffect(scale)
                        .frame(width: 375 * scale, height: 780 * scale)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }

    @ViewBuilder
    var screenContent: some View {
        switch state.screen {
        case .home:
            HomeScreenView()
        case .messages:
            MessagesListView()
        case .chat(let id):
            ChatView(characterID: id)
        }
    }
}

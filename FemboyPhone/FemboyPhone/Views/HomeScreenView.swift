import SwiftUI

struct HomeScreenView: View {
    @EnvironmentObject var state: GameState

    private let time: String = {
        let f = DateFormatter()
        f.dateFormat = "h:mm"
        return f.string(from: Date())
    }()

    var body: some View {
        ZStack {
            // Wallpaper
            LinearGradient(
                colors: [
                    Color(red: 0.08, green: 0.05, blue: 0.18),
                    Color(red: 0.18, green: 0.06, blue: 0.25),
                    Color(red: 0.05, green: 0.08, blue: 0.22),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            // Stars
            ForEach(0..<40, id: \.self) { i in
                Circle()
                    .fill(.white.opacity(Double.random(in: 0.2...0.7)))
                    .frame(width: CGFloat.random(in: 1...3))
                    .position(
                        x: CGFloat(i * 23 % 340) + 17,
                        y: CGFloat(i * 37 % 600) + 60
                    )
            }

            VStack(spacing: 0) {
                // Status bar
                HStack {
                    Text(time)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    HStack(spacing: 6) {
                        Image(systemName: "wifi")
                        Image(systemName: "battery.100")
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                }
                .padding(.horizontal, 28)
                .padding(.top, 8)

                Spacer()

                // Date & greeting
                VStack(spacing: 4) {
                    Text("FemboyPhone")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
                        .tracking(2)
                    Text("Your Phone ✨")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(.bottom, 30)

                // Notification badge
                if state.characters.contains(where: { $0.hasUnread }) {
                    HStack(spacing: 10) {
                        Image(systemName: "message.fill")
                            .foregroundColor(Color(red: 0.4, green: 0.8, blue: 1.0))
                        Text("New messages waiting...")
                            .font(.system(size: 13))
                            .foregroundColor(.white.opacity(0.9))
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(.white.opacity(0.12), in: RoundedRectangle(cornerRadius: 14))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                }

                Spacer()

                // App grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 20) {
                    AppIconButton(icon: "message.fill", label: "Messages",
                                  color: Color(red: 0.25, green: 0.78, blue: 0.35),
                                  badge: state.characters.filter(\.hasUnread).count) {
                        state.screen = .messages
                    }
                    AppIconButton(icon: "photo.fill", label: "Photos",
                                  color: Color(red: 0.95, green: 0.4, blue: 0.5)) { }
                    AppIconButton(icon: "safari.fill", label: "Safari",
                                  color: Color(red: 0.2, green: 0.5, blue: 1.0)) { }
                    AppIconButton(icon: "music.note", label: "Music",
                                  color: Color(red: 0.95, green: 0.3, blue: 0.4)) { }
                    AppIconButton(icon: "camera.fill", label: "Camera",
                                  color: Color(white: 0.25)) { }
                    AppIconButton(icon: "map.fill", label: "Maps",
                                  color: Color(red: 0.25, green: 0.75, blue: 0.5)) { }
                    AppIconButton(icon: "heart.fill", label: "Health",
                                  color: Color(red: 1.0, green: 0.3, blue: 0.4)) { }
                    AppIconButton(icon: "gear", label: "Settings",
                                  color: Color(white: 0.4)) { }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)

                // Dock
                HStack(spacing: 22) {
                    DockButton(icon: "phone.fill", color: Color(red: 0.3, green: 0.8, blue: 0.4)) { }
                    DockButton(icon: "message.fill", color: Color(red: 0.2, green: 0.75, blue: 0.35)) {
                        state.screen = .messages
                    }
                    DockButton(icon: "mail.fill", color: Color(red: 0.25, green: 0.55, blue: 1.0)) { }
                    DockButton(icon: "music.note", color: Color(red: 0.95, green: 0.35, blue: 0.45)) { }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 14)
                .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 26))
                .padding(.horizontal, 20)
                .padding(.bottom, 4)
            }
        }
    }
}

struct AppIconButton: View {
    let icon: String
    let label: String
    let color: Color
    var badge: Int = 0
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 5) {
                ZStack(alignment: .topTrailing) {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(color)
                        .frame(width: 56, height: 56)
                        .overlay(
                            Image(systemName: icon)
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                        )
                    if badge > 0 {
                        Text("\(badge)")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background(.red, in: Capsule())
                            .offset(x: 6, y: -6)
                    }
                }
                Text(label)
                    .font(.system(size: 10))
                    .foregroundColor(.white)
                    .lineLimit(1)
            }
        }
        .buttonStyle(.plain)
    }
}

struct DockButton: View {
    let icon: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 16)
                .fill(color)
                .frame(width: 58, height: 58)
                .overlay(
                    Image(systemName: icon)
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                )
        }
        .buttonStyle(.plain)
    }
}

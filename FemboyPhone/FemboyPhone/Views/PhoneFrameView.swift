import SwiftUI

struct PhoneFrameView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            // Outer shell
            RoundedRectangle(cornerRadius: 50)
                .fill(
                    LinearGradient(
                        colors: [Color(white: 0.18), Color(white: 0.10)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .strokeBorder(Color(white: 0.30), lineWidth: 1.5)
                )
                .shadow(color: .black.opacity(0.6), radius: 30, x: 0, y: 15)

            // Side buttons
            HStack {
                // Volume buttons
                VStack(spacing: 10) {
                    ForEach(0..<2) { _ in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(white: 0.22))
                            .frame(width: 5, height: 36)
                    }
                }
                .offset(x: -2, y: -30)
                Spacer()
                // Power button
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(white: 0.22))
                    .frame(width: 5, height: 52)
                    .offset(x: 2, y: -10)
            }

            // Screen
            VStack(spacing: 0) {
                // Dynamic Island
                Capsule()
                    .fill(.black)
                    .frame(width: 120, height: 34)
                    .padding(.top, 14)

                // Screen content
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                // Home indicator
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color(white: 0.5))
                    .frame(width: 130, height: 5)
                    .padding(.bottom, 10)
            }
            .clipShape(RoundedRectangle(cornerRadius: 44))
            .padding(12)
        }
        .frame(width: 375, height: 780)
    }
}

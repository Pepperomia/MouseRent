import SwiftUI

struct GlassCard<Content: View>: View {

    let content: Content

    init(
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
    }

    var body: some View {

        ZStack {

            RoundedRectangle(cornerRadius: 32)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(
                            Color.white.opacity(0.15),
                            lineWidth: 1
                        )
                )

            content
                .padding()
        }
        .shadow(
            color: .black.opacity(0.08),
            radius: 18,
            x: 0,
            y: 8
        )
    }
}

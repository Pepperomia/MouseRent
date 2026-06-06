import SwiftUI

struct MouseSticker: View {

    let imageName: String
    var size: CGFloat = 140

    var body: some View {

        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .shadow(
                color: .pink.opacity(0.2),
                radius: 10
            )
    }
}

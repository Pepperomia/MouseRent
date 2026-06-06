import SwiftUI

struct HistoryView: View {

    var body: some View {

        VStack(spacing: 20) {

            MouseSticker(
                imageName: "MouseBill2",
                size: 140
            )

            Text("История")
                .font(.largeTitle.bold())
        }
    }
}

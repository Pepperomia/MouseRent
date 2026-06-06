import SwiftUI

struct DashboardView: View {

    var body: some View {

        NavigationStack {

            ZStack {

                backgroundGradient

                ScrollView {

                    VStack(spacing: 20) {

                        header

                        summaryCard

                        quickButtons
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    DashboardView()
}

extension DashboardView {

    var backgroundGradient: some View {

        LinearGradient(
            colors: [
                Color(red: 1.0, green: 0.96, blue: 0.97),
                Color(red: 0.98, green: 0.90, blue: 0.92)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    var header: some View {

        HStack {

            VStack(alignment: .leading, spacing: 4) {

                Text("MouseRent")
                    .font(.system(size: 34, weight: .bold))
                    .tracking(-1)

                Text("Июнь 2026")
                    .foregroundStyle(.secondary)
            }

            Spacer()

            MouseSticker(
                imageName: "MouseJune",
                size: 130
            )
        }
    }

    var summaryCard: some View {

        GlassCard {

            VStack(alignment: .leading, spacing: 14) {

                HStack {

                    VStack(alignment: .leading) {

                        Text("К оплате")
                            .foregroundStyle(.secondary)

                        Text("43 041 ₽")
                            .font(.largeTitle.bold())
                    }

                    Spacer()

                    MouseSticker(
                        imageName: "MouseCheese",
                        size: 95
                    )
                }

                Divider()

                row(
                    title: "Аренда",
                    value: "41 000 ₽"
                )

                row(
                    title: "Коммуналка",
                    value: "2 341 ₽"
                )

                row(
                    title: "Переплата",
                    value: "-300 ₽"
                )
            }
        }
        .frame(height: 220)
    }

    func row(
        title: String,
        value: String
    ) -> some View {

        HStack {

            Text(title)

            Spacer()

            Text(value)
                .bold()
        }
    }

    var quickButtons: some View {

        HStack(spacing: 16) {

            quickButton(
                title: "Показания",
                image: "MouseWater1",
                destination: MonthEntryView()
            )

            quickButton(
                title: "Выставить счет",
                image: "MouseBill",
                destination: HistoryView()
            )
        }
    }

    func quickButton<Destination: View>(
        title: String,
        image: String,
        destination: Destination
    ) -> some View {

        NavigationLink {

            destination

        } label: {

            GlassCard {

                VStack {

                    Spacer()

                    MouseSticker(
                        imageName: image,
                        size: 95
                    )

                    Spacer()

                    Text(title)
                        .font(.headline)

                    Spacer()
                        .frame(height: 10)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 170)
        }
        .buttonStyle(.plain)
    }
}

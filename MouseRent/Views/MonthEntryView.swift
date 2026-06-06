import SwiftUI

struct MonthEntryView: View {

    @State private var coldWater = ""
    @State private var hotWater = ""
    @State private var electricity = ""

    var body: some View {

        ZStack {

            background

            ScrollView {

                VStack(spacing: 20) {

                    header

                    waterCard

                    electricityCard

                    summaryCard

                    saveButton
                }
                .padding()
            }
        }
    }
}

extension MonthEntryView {

    var background: some View {

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

            VStack(alignment: .leading) {

                Text("Показания")

                Text("Июнь 2026")
                    .font(.largeTitle.bold())
            }

            Spacer()

            MouseSticker(
                imageName: "MouseWater1",
                size: 110
            )
        }
    }

    var waterCard: some View {

        GlassCard {

            VStack(spacing: 18) {

                field(
                    title: "Холодная вода",
                    value: $coldWater
                )

                field(
                    title: "Горячая вода",
                    value: $hotWater
                )
            }
        }
    }

    var electricityCard: some View {

        GlassCard {

            field(
                title: "Электричество",
                value: $electricity
            )
        }
    }

    var summaryCard: some View {

        GlassCard {

            VStack(spacing: 12) {

                row(
                    title: "Водоотведение",
                    value: "\(drainageText) м³"
                )

                row(
                    title: "Коммуналка",
                    value: "\(utilitiesText) ₽"
                )
            }
        }
    }

    var saveButton: some View {

        Button {

            print("SAVE")

        } label: {

            Text("Сохранить")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.pink)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 22
                    )
                )
        }
    }

    func field(
        title: String,
        value: Binding<String>
    ) -> some View {

        VStack(alignment: .leading, spacing: 8) {

            Text(title)
                .foregroundStyle(.secondary)

            TextField(
                "0",
                text: value
            )
            .keyboardType(.decimalPad)
            .padding()
            .background(
                Color.white.opacity(0.4)
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 18
                )
            )
        }
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

    var drainageText: String {

        let cold =
        Double(coldWater) ?? 0

        let hot =
        Double(hotWater) ?? 0

        return String(
            format: "%.1f",
            cold + hot
        )
    }

    var utilitiesText: String {

        let cold =
        Double(coldWater) ?? 0

        let hot =
        Double(hotWater) ?? 0

        let electricityValue =
        Double(electricity) ?? 0

        let mockTariff = Tariff(
            coldWaterRate: 50,
            hotWaterRate: 120,
            drainageRate: 40,
            electricityRate: 6
        )

        let result =
        CalculationService.shared
            .calculateUtilities(
                coldUsage: cold,
                hotUsage: hot,
                electricityUsage: electricityValue,
                tariff: mockTariff
            )

        return String(
            format: "%.0f",
            result
        )
    }
}

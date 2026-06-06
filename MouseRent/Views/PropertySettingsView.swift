import SwiftUI
import SwiftData

struct PropertySettingsView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var context

    let property: Property

    @State private var title: String
    @State private var address: String
    @State private var rentAmount: String

    @State private var coldWaterRate: String
    @State private var hotWaterRate: String
    @State private var drainageRate: String
    @State private var electricityRate: String

    @State private var startColdWater: String
    @State private var startHotWater: String
    @State private var startElectricity: String

    init(property: Property) {

        self.property = property

        _title = State(initialValue: property.title)
        _address = State(initialValue: property.address)

        _rentAmount = State(
            initialValue: String(property.rentAmount)
        )

        _coldWaterRate = State(
            initialValue: String(property.coldWaterRate)
        )

        _hotWaterRate = State(
            initialValue: String(property.hotWaterRate)
        )

        _drainageRate = State(
            initialValue: String(property.drainageRate)
        )

        _electricityRate = State(
            initialValue: String(property.electricityRate)
        )

        _startColdWater = State(
            initialValue: String(property.startColdWater)
        )

        _startHotWater = State(
            initialValue: String(property.startHotWater)
        )

        _startElectricity = State(
            initialValue: String(property.startElectricity)
        )
    }

    var body: some View {

        NavigationStack {

            ZStack {

                background

                ScrollView {

                    VStack(spacing: 20) {

                        MouseSticker(
                            imageName: "MouseSettings",
                            size: 140
                        )

                        GlassCard {

                            VStack(spacing: 16) {

                                field(
                                    title: "Название",
                                    text: $title
                                )

                                field(
                                    title: "Адрес",
                                    text: $address
                                )

                                field(
                                    title: "Аренда",
                                    text: $rentAmount
                                )
                            }
                        }

                        GlassCard {

                            VStack(spacing: 16) {

                                Text("Тарифы")
                                    .font(.headline)

                                field(
                                    title: "Холодная вода",
                                    text: $coldWaterRate
                                )

                                field(
                                    title: "Горячая вода",
                                    text: $hotWaterRate
                                )

                                field(
                                    title: "Водоотведение",
                                    text: $drainageRate
                                )

                                field(
                                    title: "Электричество",
                                    text: $electricityRate
                                )
                            }
                        }

                        GlassCard {

                            VStack(spacing: 16) {

                                Text("Стартовые показания")
                                    .font(.headline)

                                field(
                                    title: "Холодная вода",
                                    text: $startColdWater
                                )

                                field(
                                    title: "Горячая вода",
                                    text: $startHotWater
                                )

                                field(
                                    title: "Электричество",
                                    text: $startElectricity
                                )
                            }
                        }

                        Button {

                            saveChanges()

                        } label: {

                            Text("Сохранить")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.pink)
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 20
                                    )
                                )
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Настройки")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func field(
        title: String,
        text: Binding<String>
    ) -> some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Text(title)
                .foregroundStyle(.secondary)

            TextField(
                "Введите значение",
                text: text
            )
            .padding()
            .background(
                Color.white.opacity(0.4)
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 16
                )
            )
        }
    }

    func saveChanges() {

        property.title = title
        property.address = address

        property.rentAmount =
        Double(rentAmount.replacingOccurrences(of: ",", with: ".")) ?? 0

        property.coldWaterRate =
        Double(coldWaterRate.replacingOccurrences(of: ",", with: ".")) ?? 0

        property.hotWaterRate =
        Double(hotWaterRate.replacingOccurrences(of: ",", with: ".")) ?? 0

        property.drainageRate =
        Double(drainageRate.replacingOccurrences(of: ",", with: ".")) ?? 0

        property.electricityRate =
        Double(electricityRate.replacingOccurrences(of: ",", with: ".")) ?? 0

        property.startColdWater =
        Double(startColdWater.replacingOccurrences(of: ",", with: ".")) ?? 0

        property.startHotWater =
        Double(startHotWater.replacingOccurrences(of: ",", with: ".")) ?? 0

        property.startElectricity =
        Double(startElectricity.replacingOccurrences(of: ",", with: ".")) ?? 0

        try? context.save()

        dismiss()
    }
}

extension PropertySettingsView {

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
}

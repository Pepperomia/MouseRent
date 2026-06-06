import SwiftUI

struct TenantInvoiceView: View {

    let property: Property
    let entry: MeterEntry

    var body: some View {

        ScrollView {

            VStack(
                alignment: .leading,
                spacing: 20
            ) {

                Text(property.title)

                    .font(.title.bold())

                Text("Расчёт за \(monthTitle)")

                    .foregroundStyle(.secondary)
                    .font(.largeTitle.bold())

                Divider()

                invoiceRow(
                    title: "Аренда",
                    value: property.rentAmount
                )

                Divider()

                Text("Коммунальные услуги")
                    .font(.title3.bold())

                utilityRow(
                    title: "Холодная вода",
                    usage: entry.coldWaterUsage,
                    rate: entry.coldWaterRate,
                    cost: entry.coldWaterCost,
                    unit: "м³"
                )

                utilityRow(
                    title: "Горячая вода",
                    usage: entry.hotWaterUsage,
                    rate: entry.hotWaterRate,
                    cost: entry.hotWaterCost,
                    unit: "м³"
                )

                utilityRow(
                    title: "Водоотведение",
                    usage: entry.coldWaterUsage + entry.hotWaterUsage,
                    rate: entry.drainageRate,
                    cost: entry.drainageCost,
                    unit: "м³"
                )

                utilityRow(
                    title: "Электричество",
                    usage: entry.electricityUsage,
                    rate: entry.electricityRate,
                    cost: entry.electricityCost,
                    unit: "кВт"
                )

                Divider()

                invoiceRow(
                    title: "Коммунальные услуги",
                    value: entry.utilitiesTotal
                )

                invoiceRow(
                    title: "Итого к оплате",
                    value: property.rentAmount + entry.utilitiesTotal,
                    bold: true
                )
                
                Divider()

                ShareLink(
                    item: shareText
                ) {

                    HStack {

                        Image(systemName: "square.and.arrow.up")

                        Text("Поделиться")
                    }
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.pink)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 16
                        )
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Счёт")
        .navigationBarTitleDisplayMode(.inline)
    }

    var monthTitle: String {

        let formatter = DateFormatter()

        formatter.locale = Locale(

            identifier: "ru_RU"

        )

        formatter.dateFormat = "LLLL yyyy"

        return formatter.string(

            from: entry.date

        ).capitalized

    }

    func invoiceRow(
        title: String,
        value: Double,
        bold: Bool = false
    ) -> some View {

        HStack {

            Text(title)

            Spacer()

            Text("\(Int(value)) ₽")
                .fontWeight(
                    bold ? .bold : .regular
                )
        }
    }

    func utilityRow(
        title: String,
        usage: Double,
        rate: Double,
        cost: Double,
        unit: String
    ) -> some View {

        VStack(
            alignment: .leading,
            spacing: 4
        ) {

            Text(title)
                .fontWeight(.semibold)

            Text(
                "\(usage.formatted(.number.precision(.fractionLength(1)))) \(unit) × \(Int(rate)) ₽"
            )
            .foregroundStyle(.secondary)

            Text("\(Int(cost)) ₽")
        }
    }
    
    var shareText: String {

        """
        Квартира: \(property.title)

        Расчёт за \(monthTitle)

        Показания счётчиков

        ХВ: \(Int(entry.coldWater - entry.coldWaterUsage)) → \(Int(entry.coldWater))
        ГВ: \(Int(entry.hotWater - entry.hotWaterUsage)) → \(Int(entry.hotWater))
        Эл: \(Int(entry.electricity - entry.electricityUsage)) → \(Int(entry.electricity))

        Коммунальные услуги

        Холодная вода:
        \(entry.coldWaterUsage.formatted(.number.precision(.fractionLength(1)))) м³ × \(Int(entry.coldWaterRate)) ₽ = \(Int(entry.coldWaterCost)) ₽

        Горячая вода:
        \(entry.hotWaterUsage.formatted(.number.precision(.fractionLength(1)))) м³ × \(Int(entry.hotWaterRate)) ₽ = \(Int(entry.hotWaterCost)) ₽

        Водоотведение:
        \((entry.coldWaterUsage + entry.hotWaterUsage).formatted(.number.precision(.fractionLength(1)))) м³ × \(Int(entry.drainageRate)) ₽ = \(Int(entry.drainageCost)) ₽

        Электричество:
        \(Int(entry.electricityUsage)) кВт × \(Int(entry.electricityRate)) ₽ = \(Int(entry.electricityCost)) ₽

        Коммунальные услуги:
        \(Int(entry.utilitiesTotal)) ₽

        Аренда:
        \(Int(property.rentAmount)) ₽

        Итого к оплате:
        \(Int(property.rentAmount + entry.utilitiesTotal)) ₽
        """
    }
}

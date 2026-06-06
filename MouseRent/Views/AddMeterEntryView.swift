import SwiftUI
import SwiftData

struct AddMeterEntryView: View {

    let property: Property

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var context

    @State private var coldWater = ""
    @State private var hotWater = ""
    @State private var electricity = ""

    @State private var selectedDate = Date()
    @State private var showDatePicker = false

    var body: some View {

        NavigationStack {

            ZStack {

                background

                ScrollView {

                    VStack(spacing: 20) {

                        GlassCard {

                            VStack(
                                alignment: .leading,
                                spacing: 18
                            ) {

                                Text("Новые показания")
                                    .font(.title2.bold())

                                VStack(alignment: .leading) {

                                    Text("Холодная вода")

                                    TextField(
                                        "Например 125",
                                        text: $coldWater
                                    )
                                    .keyboardType(.decimalPad)
                                }

                                VStack(alignment: .leading) {

                                    Text("Горячая вода")

                                    TextField(
                                        "Например 84",
                                        text: $hotWater
                                    )
                                    .keyboardType(.decimalPad)
                                }

                                VStack(alignment: .leading) {

                                    Text("Электричество")

                                    TextField(
                                        "Например 4567",
                                        text: $electricity
                                    )
                                    .keyboardType(.decimalPad)
                                }

                                VStack(alignment: .leading, spacing: 8) {

                                    Text("Дата")

                                    Button {

                                        showDatePicker.toggle()

                                    } label: {

                                        HStack {

                                            Text(
                                                selectedDate.formatted(
                                                    date: .abbreviated,
                                                    time: .omitted
                                                )
                                            )

                                            Spacer()

                                            Image(systemName: "calendar")
                                        }
                                        .foregroundStyle(.primary)
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
                                    .popover(isPresented: $showDatePicker) {

                                        DatePicker(
                                            "Дата",
                                            selection: Binding(
                                                get: { selectedDate },
                                                set: { newValue in

                                                    selectedDate = newValue
                                                    showDatePicker = false
                                                }
                                            ),
                                            displayedComponents: .date
                                        )
                                        .datePickerStyle(.graphical)
                                        .padding()
                                    }
                                }
                            }
                        }

                        Button {

                            saveEntry()

                        } label: {

                            Text("Сохранить показания")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.pink)
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 18
                                    )
                                )
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Показания")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension AddMeterEntryView {
    
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
    
    var previousEntry: MeterEntry? {
        
        property.entries
            .sorted { $0.date > $1.date }
            .first
    }
    
    var previousColdWater: Double {
        
        previousEntry?.coldWater
        ?? property.startColdWater
    }
    
    var previousHotWater: Double {
        
        previousEntry?.hotWater
        ?? property.startHotWater
    }
    
    var previousElectricity: Double {
        
        previousEntry?.electricity
        ?? property.startElectricity
    }
    
    var currentColdWater: Double {
        
        Double(coldWater) ?? 0
    }
    
    var currentHotWater: Double {
        
        Double(hotWater) ?? 0
    }
    
    var currentElectricity: Double {
        
        Double(electricity) ?? 0
    }
    
    var coldUsage: Double {
        
        max(
            currentColdWater - previousColdWater,
            0
        )
    }
    
    var hotUsage: Double {
        
        max(
            currentHotWater - previousHotWater,
            0
        )
    }
    
    var electricityUsage: Double {
        
        max(
            currentElectricity - previousElectricity,
            0
        )
    }
    
    var coldCost: Double {
        
        coldUsage * property.coldWaterRate
    }
    
    var hotCost: Double {
        
        hotUsage * property.hotWaterRate
    }
    
    var drainageCost: Double {
        
        (coldUsage + hotUsage)
        * property.drainageRate
    }
    
    var electricityCost: Double {
        
        electricityUsage
        * property.electricityRate
    }
    
    var utilitiesTotal: Double {
        
        coldCost
        + hotCost
        + drainageCost
        + electricityCost
    }
    
    func saveEntry() {
        
        let lastEntry = property.entries
            .sorted { $0.date > $1.date }
            .first
        
        let previousCold =
        lastEntry?.coldWater
        ?? property.startColdWater
        
        let previousHot =
        lastEntry?.hotWater
        ?? property.startHotWater
        
        let previousElectricity =
        lastEntry?.electricity
        ?? property.startElectricity
        
        let currentCold =
        Double(coldWater) ?? 0
        
        let currentHot =
        Double(hotWater) ?? 0
        
        let currentElectricity =
        Double(electricity) ?? 0
        
        let coldUsage =
        max(currentCold - previousCold, 0)
        
        let hotUsage =
        max(currentHot - previousHot, 0)
        
        let electricityUsage =
        max(currentElectricity - previousElectricity, 0)
        
        let coldCost =
        coldUsage * property.coldWaterRate
        
        let hotCost =
        hotUsage * property.hotWaterRate
        
        let drainageCost =
        (coldUsage + hotUsage)
        * property.drainageRate
        
        let electricityCost =
        electricityUsage
        * property.electricityRate
        
        let utilitiesTotal =
        coldCost
        + hotCost
        + drainageCost
        + electricityCost
        
        let entry = MeterEntry(
            
            date: selectedDate,
            
            property: property,
            
            coldWater: currentCold,
            hotWater: currentHot,
            electricity: currentElectricity,
            
            coldWaterUsage: coldUsage,
            hotWaterUsage: hotUsage,
            electricityUsage: electricityUsage,
            
            coldWaterRate: property.coldWaterRate,
            hotWaterRate: property.hotWaterRate,
            drainageRate: property.drainageRate,
            electricityRate: property.electricityRate,
            
            coldWaterCost: coldCost,
            hotWaterCost: hotCost,
            drainageCost: drainageCost,
            electricityCost: electricityCost,
            
            utilitiesTotal: utilitiesTotal
        )
        
        context.insert(entry)
        
        property.entries.append(entry)
        
        try? context.save()
        
        dismiss()
    }
}

import SwiftUI
import SwiftData

struct PropertyDashboardView: View {

    @Environment(\.modelContext)
    private var modelContext

    let property: Property

    @State private var showAddSheet = false
    @State private var expandedEntryId: PersistentIdentifier?
    @State private var showSettingsSheet = false

    var sortedEntries: [MeterEntry] {

        property.entries.sorted {
            $0.date > $1.date
        }
    }

    var body: some View {

        ZStack {

            background

            if sortedEntries.isEmpty {

                emptyState

            } else {

                entriesList
            }
        }
        .navigationTitle(property.title)
        .toolbar {

            ToolbarItemGroup(
                placement: .topBarTrailing
            ) {

                Button {

                    showSettingsSheet = true

                } label: {

                    Image(systemName: "gearshape")
                }

                Button {

                    showAddSheet = true

                } label: {

                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {

            AddMeterEntryView(
                property: property
            )
        }
        .sheet(isPresented: $showSettingsSheet) {

            PropertySettingsView(
                property: property
            )
        }
    }
}

// MARK: - UI

extension PropertyDashboardView {

    var background: some View {

        LinearGradient(
            colors: [
                Color(
                    red: 1.0,
                    green: 0.96,
                    blue: 0.97
                ),
                Color(
                    red: 0.98,
                    green: 0.90,
                    blue: 0.92
                )
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    var emptyState: some View {

        VStack(spacing: 24) {

            Spacer()

            MouseSticker(
                imageName: "MouseBill",
                size: 180
            )

            VStack(spacing: 8) {

                Text("Пока нет показаний")
                    .font(.title2.bold())

                Text("Добавим первую запись?")
                    .foregroundStyle(.secondary)
            }

            Button {

                showAddSheet = true

            } label: {

                Text("Добавить показания")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 14)
                    .background(.pink)
                    .clipShape(Capsule())
            }

            Spacer()
        }
        .padding()
    }

    var entriesList: some View {
        
        ScrollView {
            
            VStack(spacing: 18) {
                
                HStack {

                    Spacer()

                    MouseSticker(

                        imageName: "MouseBill2",

                        size: 240

                    )

                }

                .padding(.trailing, -20)

                .padding(.bottom, -20)
                
                ForEach(sortedEntries) { entry in
                    
                    GlassCard {
                        
                        VStack(
                            alignment: .leading,
                            spacing: 14
                        ) {
                            
                            Button {
                                
                                if expandedEntryId == entry.id {
                                    
                                    expandedEntryId = nil
                                    
                                } else {
                                    
                                    expandedEntryId = entry.id
                                }
                                
                            } label: {
                                
                                HStack {
                                    
                                    VStack(

                                        alignment: .leading,

                                        spacing: 4

                                    ) {

                                        Text(monthTitle(for: entry))

                                            .font(.title3.bold())

                                    }
                                    
                                    Spacer()
                                    
                                    Image(
                                        systemName:
                                            expandedEntryId == entry.id
                                        ? "chevron.up"
                                        : "chevron.down"
                                    )
                                }
                            }
                            .buttonStyle(.plain)
                            
                            if expandedEntryId == entry.id {
                                
                                HStack {

                                    Text(
                                        entry.date.formatted(
                                            date: .long,
                                            time: .omitted
                                        )
                                    )
                                    .foregroundStyle(.secondary)

                                    Spacer()

                                    MouseSticker(
                                        imageName: mouseForMonth(
                                            entry.date
                                        ),
                                        size: 90
                                    )
                                }
                                
                                Divider()
                                
                                VStack(spacing: 10) {
                                    
                                    dashboardRow(
                                        title: "Аренда",
                                        value: property.rentAmount
                                    )
                                    
                                    dashboardRow(
                                        title: "Коммуналка",
                                        value: entry.utilitiesTotal
                                    )
                                    
                                    Divider()
                                    
                                    dashboardRow(
                                        title: "Холодная вода",
                                        subtitle: "\(entry.coldWaterUsage.formatted(.number.precision(.fractionLength(1)))) м³",
                                        value: entry.coldWaterCost
                                    )
                                    
                                    dashboardRow(
                                        title: "Горячая вода",
                                        subtitle: "\(entry.hotWaterUsage.formatted(.number.precision(.fractionLength(1)))) м³",
                                        value: entry.hotWaterCost
                                    )
                                    
                                    dashboardRow(
                                        title: "Водоотведение",
                                        subtitle: "\((entry.coldWaterUsage + entry.hotWaterUsage).formatted(.number.precision(.fractionLength(1)))) м³",
                                        value: entry.drainageCost
                                    )
                                    
                                    dashboardRow(
                                        title: "Электричество",
                                        subtitle: "\(Int(entry.electricityUsage)) кВт",
                                        value: entry.electricityCost
                                    )
                                }
                                
                                Divider()
                                
                                VStack(
                                    alignment: .leading,
                                    spacing: 8
                                ) {
                                    
                                    Text("Показания")
                                        .font(.headline)
                                    
                                    HStack {
                                        
                                        VStack(alignment: .leading) {
                                            
                                            Text("Текущие")
                                                .fontWeight(.semibold)
                                            
                                            Text("ХВ: \(Int(entry.coldWater))")
                                            Text("ГВ: \(Int(entry.hotWater))")
                                            Text("Эл: \(Int(entry.electricity))")
                                        }
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .leading) {
                                            
                                            Text("Предыдущие")
                                                .fontWeight(.semibold)
                                            
                                            Text("ХВ: \(Int(entry.coldWater - entry.coldWaterUsage))")
                                            Text("ГВ: \(Int(entry.hotWater - entry.hotWaterUsage))")
                                            Text("Эл: \(Int(entry.electricity - entry.electricityUsage))")
                                        }
                                    }
                                }
                                
                                Divider()
                                
                                HStack {
                                    
                                    Text("Итого")
                                        .font(.title3.bold())
                                    
                                    Spacer()
                                    
                                    Text(
                                        "\(Int(property.rentAmount + entry.utilitiesTotal)) ₽"
                                    )
                                    .font(.title3.bold())
                                }
                                NavigationLink {
                                    
                                    TenantInvoiceView(
                                        property: property,
                                        entry: entry
                                    )
                                    
                                } label: {
                                    
                                    HStack {
                                        
                                        Image(systemName: "paperplane")
                                        
                                        Text("Отправить арендатору")
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
                        }
                        .swipeActions {
                            
                            Button(
                                role: .destructive
                            ) {
                                
                                delete(entry)
                                
                            } label: {
                                
                                Label(
                                    "Удалить",
                                    systemImage: "trash"
                                )
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }

    func dashboardRow(
        title: String,
        subtitle: String? = nil,
        value: Double
    ) -> some View {

        HStack {

            VStack(alignment: .leading) {

                Text(title)

                if let subtitle {

                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            Text("\(Int(value)) ₽")
                .fontWeight(.semibold)
        }
    }

    var randomMouse: String {

        [
            "MouseBook",
            "MouseHouse",
            "MouseNo"
        ].randomElement() ?? "MouseBook"
    }

    func delete(_ entry: MeterEntry) {

        if let index = property.entries.firstIndex(where: {

            $0.persistentModelID == entry.persistentModelID

        }) {

            property.entries.remove(at: index)
        }

        modelContext.delete(entry)

        try? modelContext.save()
    }
    func monthTitle(

        for entry: MeterEntry

    ) -> String {

        let formatter = DateFormatter()

        formatter.locale = Locale(

            identifier: "ru_RU"

        )

        formatter.dateFormat = "LLLL yyyy"

        return formatter.string(

            from: entry.date

        ).capitalized

    }
    
    func mouseForMonth(
        _ date: Date
    ) -> String {

        let month = Calendar.current.component(
            .month,
            from: date
        )

        switch month {

        case 1:
            return "MouseJanuary"

        case 2:
            return "MouseFebruary"

        case 3:
            return "MouseMart"

        case 4:
            return "MouseApril"

        case 5:
            return "MouseMay"

        case 6:
            return "MouseJune"

        case 7:
            return "MouseJuly"

        case 8:
            return "MouseAugust"

        case 9:
            return "MouseSeptembr"

        case 10:
            return "MouseOctober"

        case 11:
            return "MouseNovember"

        case 12:
            return "MouseDecember"

        default:
            return "MouseHouse"
        }
    }
}

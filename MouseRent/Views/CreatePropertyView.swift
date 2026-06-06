import SwiftUI
import SwiftData

struct CreatePropertyView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var context

    @State private var name = ""
    @State private var address = ""

    @State private var rent = ""

    @State private var coldWater = ""
    @State private var hotWater = ""
    @State private var electricity = ""

    @State private var coldTariff = ""
    @State private var hotTariff = ""
    @State private var drainageTariff = ""
    @State private var electricityTariff = ""

    var body: some View {

        NavigationStack {

            ZStack {

                background

                ScrollView {

                    VStack(spacing: 20) {

                        header

                        propertyCard

                        metersCard

                        tariffsCard

                        saveButton
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension CreatePropertyView {
    
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
                
                Text("Новый объект")
                    .font(.largeTitle.bold())
                
                Text("Добавим квартиру 🐭")
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            MouseSticker(
                imageName: "MouseHouse",
                size: 120
            )
        }
    }
    
    var propertyCard: some View {
        
        GlassCard {
            
            VStack(spacing: 16) {
                
                field(
                    title: "Название",
                    text: $name
                )
                
                field(
                    title: "Адрес",
                    text: $address
                )
                
                field(
                    title: "Аренда",
                    text: $rent
                )
            }
        }
    }
    
    var metersCard: some View {
        
        GlassCard {
            
            VStack(spacing: 16) {
                
                field(
                    title: "Холодная вода",
                    text: $coldWater
                )
                
                field(
                    title: "Горячая вода",
                    text: $hotWater
                )
                
                field(
                    title: "Электричество",
                    text: $electricity
                )
            }
        }
    }
    
    var tariffsCard: some View {
        
        GlassCard {
            
            VStack(spacing: 16) {
                
                field(
                    title: "Тариф ХВ",
                    text: $coldTariff
                )
                
                field(
                    title: "Тариф ГВ",
                    text: $hotTariff
                )
                
                field(
                    title: "Водоотведение",
                    text: $drainageTariff
                )
                
                field(
                    title: "Электричество",
                    text: $electricityTariff
                )
            }
        }
    }
    
    var saveButton: some View {
        
        Button {
            
            saveProperty()
            
        } label: {
            
            Text("Сохранить")
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.pink)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 24
                    )
                )
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
                    cornerRadius: 18
                )
            )
        }
    }
    
    func saveProperty() {
        
        let property = Property(
            
            title: name,
            address: address,
            
            rentAmount: Double(rent) ?? 0,
            
            coldWaterRate: Double(coldTariff) ?? 0,
            hotWaterRate: Double(hotTariff) ?? 0,
            electricityRate: Double(electricityTariff) ?? 0,
            drainageRate: Double(drainageTariff) ?? 0,
            
            startColdWater: Double(coldWater) ?? 0,
            startHotWater: Double(hotWater) ?? 0,
            startElectricity: Double(electricity) ?? 0
        )
        
        context.insert(property)
        
        do {
            
            try context.save()
            
            dismiss()
            
        } catch {
            
            print(error.localizedDescription)
        }
    }
}

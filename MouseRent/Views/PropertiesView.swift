import SwiftUI
import SwiftData

struct PropertiesView: View {
    
    @Environment(\.modelContext)
    private var context
    
    @Query
    private var properties: [Property]

    @State
    private var showCreateSheet = false

    var body: some View {

        NavigationStack {

            ZStack {

                background

                if properties.isEmpty {

                    emptyState

                } else {

                    propertiesList
                }
            }
            .navigationTitle("MouseRent")
            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {

                    Button {

                        showCreateSheet = true

                    } label: {

                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showCreateSheet) {

                CreatePropertyView()
            }
        }
    }
}

extension PropertiesView {
    
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
    
    var emptyState: some View {
        
        VStack(spacing: 24) {
            
            Spacer()
            
            MouseSticker(
                imageName: "MouseNo",
                size: 180
            )
            
            VStack(spacing: 10) {
                
                Text("Пока нет квартир")
                    .font(.title.bold())
                
                Text("Добавим первый объект?")
                    .foregroundStyle(.secondary)
            }
            
            Button {
                
                showCreateSheet = true
                
            } label: {
                
                Text("Добавить объект")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 14)
                    .background(.pink)
                    .clipShape(
                        Capsule()
                    )
            }
            
            Spacer()
        }
        .padding()
    }
    
    var propertiesList: some View {
        
        List {
            
            ForEach(properties) { property in
                
                NavigationLink {
                    
                    PropertyDashboardView(
                        property: property
                    )
                    
                } label: {
                    
                    GlassCard {
                        
                        HStack {
                            
                            VStack(
                                alignment: .leading,
                                spacing: 8
                            ) {
                                
                                Text(property.title)
                                    .font(.title3.bold())
                                
                                Text(property.address)
                                    .foregroundStyle(.secondary)
                                
                                Text(
                                    "\(Int(property.rentAmount)) ₽"
                                )
                                .fontWeight(.semibold)
                            }
                            
                            Spacer()
                            
                            MouseSticker(
                                imageName: "MouseHouse",
                                size: 100
                            )
                        }
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
                .swipeActions {
                    
                    Button(
                        role: .destructive
                    ) {
                        
                        context.delete(property)
                        try? context.save()
                        
                    } label: {
                        
                        Label(
                            "Удалить",
                            systemImage: "trash"
                        )
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
    }
}

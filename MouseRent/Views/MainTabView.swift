import SwiftUI

struct MainTabView: View {

    var body: some View {

        TabView {

            PropertiesView()
                .tabItem {

                    Label(
                        "Квартиры",
                        systemImage: "house.fill"
                    )
                }

            AnalyticsView()
                .tabItem {

                    Label(
                        "Аналитика",
                        systemImage: "chart.bar.fill"
                    )
                }

            IncomeView()
                .tabItem {

                    Label(
                        "Доход",
                        systemImage: "rublesign.circle.fill"
                    )
                }

            SettingsView()
                .tabItem {

                    Label(
                        "Настройки",
                        systemImage: "gearshape.fill"
                    )
                }
        }
        .tint(.pink)
    }
}

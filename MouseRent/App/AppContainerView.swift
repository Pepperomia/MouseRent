import SwiftUI

struct AppContainerView: View {

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
                        systemImage: "chart.line.uptrend.xyaxis"
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

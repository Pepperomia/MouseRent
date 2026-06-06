import SwiftUI
import SwiftData

@main
struct MouseRentApp: App {

    var body: some Scene {

        WindowGroup {

            MainTabView()
        }
        .modelContainer(
            for: [
                Property.self,
                MeterEntry.self
            ]
        )
    }
}

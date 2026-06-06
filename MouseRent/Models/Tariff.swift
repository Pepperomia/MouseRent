import Foundation
import SwiftData

@Model
final class Tariff {

    var coldWaterRate: Double
    var hotWaterRate: Double
    var drainageRate: Double
    var electricityRate: Double

    init(
        coldWaterRate: Double,
        hotWaterRate: Double,
        drainageRate: Double,
        electricityRate: Double
    ) {
        self.coldWaterRate = coldWaterRate
        self.hotWaterRate = hotWaterRate
        self.drainageRate = drainageRate
        self.electricityRate = electricityRate
    }
}

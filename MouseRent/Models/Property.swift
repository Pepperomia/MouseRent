import Foundation
import SwiftData

@Model
final class Property {
    

    var title: String
    var address: String

    // аренда
    var rentAmount: Double

    // тарифы
    var coldWaterRate: Double
    var hotWaterRate: Double
    var electricityRate: Double
    var drainageRate: Double

    // стартовые показания
    var startColdWater: Double
    var startHotWater: Double
    var startElectricity: Double

    // показания
    @Relationship(deleteRule: .cascade)
    var entries: [MeterEntry] = []
    
    @Relationship(deleteRule: .cascade)
    var meterEntries: [MeterEntry] = []

    init(
        title: String,
        address: String,
        rentAmount: Double,

        coldWaterRate: Double,
        hotWaterRate: Double,
        electricityRate: Double,
        drainageRate: Double,

        startColdWater: Double,
        startHotWater: Double,
        startElectricity: Double
    ) {

        self.title = title
        self.address = address

        self.rentAmount = rentAmount

        self.coldWaterRate = coldWaterRate
        self.hotWaterRate = hotWaterRate
        self.electricityRate = electricityRate
        self.drainageRate = drainageRate

        self.startColdWater = startColdWater
        self.startHotWater = startHotWater
        self.startElectricity = startElectricity
    }
}

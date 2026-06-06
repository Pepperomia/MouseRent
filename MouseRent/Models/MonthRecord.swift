import Foundation
import SwiftData

@Model
final class MonthRecord {

    var month: Int
    var year: Int

    var coldWater: Double
    var hotWater: Double
    var electricity: Double

    var coldWaterUsage: Double
    var hotWaterUsage: Double
    var electricityUsage: Double

    var drainage: Double

    var utilitiesTotal: Double
    var totalAmount: Double

    var carryOver: Double

    var createdAt: Date

    var property: Property?

    init(
        month: Int,
        year: Int
    ) {
        self.month = month
        self.year = year

        self.coldWater = 0
        self.hotWater = 0
        self.electricity = 0

        self.coldWaterUsage = 0
        self.hotWaterUsage = 0
        self.electricityUsage = 0

        self.drainage = 0

        self.utilitiesTotal = 0
        self.totalAmount = 0

        self.carryOver = 0

        self.createdAt = .now
    }
}

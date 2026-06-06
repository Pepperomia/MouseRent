import Foundation
import SwiftData

@Model
final class MeterEntry {

    // MARK: - Основное

    var date: Date

    // связь с квартирой
    var property: Property?

    // MARK: - Показания

    var coldWater: Double
    var hotWater: Double
    var electricity: Double

    // MARK: - Расход

    var coldWaterUsage: Double
    var hotWaterUsage: Double
    var electricityUsage: Double

    // MARK: - Тарифы

    var coldWaterRate: Double
    var hotWaterRate: Double
    var drainageRate: Double
    var electricityRate: Double

    // MARK: - Стоимость

    var coldWaterCost: Double = 0
    var hotWaterCost: Double = 0
    var drainageCost: Double = 0
    var electricityCost: Double = 0

    // общая коммуналка
    var utilitiesTotal: Double = 0

    // доход от аренды
    var rentIncome: Double = 0

    // сколько реально заплатили
    var totalPaid: Double = 0

    // MARK: - Init

    init(
        date: Date,

        property: Property? = nil,

        coldWater: Double,
        hotWater: Double,
        electricity: Double,

        coldWaterUsage: Double,
        hotWaterUsage: Double,
        electricityUsage: Double,

        coldWaterRate: Double,
        hotWaterRate: Double,
        drainageRate: Double,
        electricityRate: Double,

        coldWaterCost: Double = 0,
        hotWaterCost: Double = 0,
        drainageCost: Double = 0,
        electricityCost: Double = 0,

        utilitiesTotal: Double = 0,

        rentIncome: Double = 0,

        totalPaid: Double = 0
    ) {

        self.date = date

        self.property = property

        self.coldWater = coldWater
        self.hotWater = hotWater
        self.electricity = electricity

        self.coldWaterUsage = coldWaterUsage
        self.hotWaterUsage = hotWaterUsage
        self.electricityUsage = electricityUsage

        self.coldWaterRate = coldWaterRate
        self.hotWaterRate = hotWaterRate
        self.drainageRate = drainageRate
        self.electricityRate = electricityRate

        self.coldWaterCost = coldWaterCost
        self.hotWaterCost = hotWaterCost
        self.drainageCost = drainageCost
        self.electricityCost = electricityCost

        self.utilitiesTotal = utilitiesTotal

        self.rentIncome = rentIncome

        self.totalPaid = totalPaid
    }
}

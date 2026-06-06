import Foundation

final class CalculationService {

    static let shared = CalculationService()

    private init() {}

    func calculateDrainage(
        cold: Double,
        hot: Double
    ) -> Double {

        cold + hot
    }

    func calculateUtilities(
        coldUsage: Double,
        hotUsage: Double,
        electricityUsage: Double,
        tariff: Tariff
    ) -> Double {

        let cold =
        coldUsage * tariff.coldWaterRate

        let hot =
        hotUsage * tariff.hotWaterRate

        let drainage =
        (coldUsage + hotUsage)
        * tariff.drainageRate

        let electricity =
        electricityUsage
        * tariff.electricityRate

        return cold
        + hot
        + drainage
        + electricity
    }
}

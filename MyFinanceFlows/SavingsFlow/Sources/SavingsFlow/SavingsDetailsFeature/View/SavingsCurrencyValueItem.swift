import Foundation

struct SavingsCurrencyValueItem: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var currency: String
    var value: Double
}

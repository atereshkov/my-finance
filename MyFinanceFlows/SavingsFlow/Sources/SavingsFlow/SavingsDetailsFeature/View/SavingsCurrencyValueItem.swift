import Foundation

struct SavingsCurrencyValueItem: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var currency: String
    var value: Double

    var currencyIconName: String {
        switch currency {
        case "USD": return "dollarsign.circle"
        case "EUR": return "eurosign.circle"
        default: return "circle"
        }
    }
}

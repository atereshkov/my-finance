import Foundation

public struct SavingsDTO {
    var id: String
    var name: String
    var currency: String

    var startValue: Double
    var currentValue: Double

    var startDate: Double

    public init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? ""
        self.currency = data["currency"] as? String ?? ""
        self.startValue = data["startValue"] as? Double ?? 0.0
        self.currentValue = data["currentValue"] as? Double ?? 0.0
        self.startDate = data["startDate"] as? Double ?? 0
    }
}

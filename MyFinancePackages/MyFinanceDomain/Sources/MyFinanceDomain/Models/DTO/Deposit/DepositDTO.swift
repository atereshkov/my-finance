import Foundation

public struct DepositDTO {
    var id: String
    var name: String
    var currency: String

    var goalValue: Double
    var startValue: Double
    var currentValue: Double

    var startDate: Double
    var endDate: Double

    public init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? ""
        self.currency = data["currency"] as? String ?? ""
        self.goalValue = data["goalValue"] as? Double ?? 0.0
        self.startValue = data["startValue"] as? Double ?? 0.0
        self.currentValue = data["currentValue"] as? Double ?? 0.0
        self.startDate = data["startDate"] as? Double ?? 0
        self.endDate = data["endDate"] as? Double ?? 0
    }
}

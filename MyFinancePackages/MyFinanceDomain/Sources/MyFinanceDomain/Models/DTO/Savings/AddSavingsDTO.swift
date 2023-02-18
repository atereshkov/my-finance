import Foundation

public struct AddSavingsDTO {
    var name: String
    var currency: String

    var startValue: Double
    var currentValue: Double

    var startDate: Date

    public init(_ data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.currency = data["currency"] as? String ?? ""
        self.startValue = data["startValue"] as? Double ?? 0.0
        self.currentValue = data["currentValue"] as? Double ?? 0.0
        self.startDate = data["startDate"] as? Date ?? Date()
    }

    public func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "currency": currency,
            "startValue": startValue,
            "currentValue": currentValue,
            "startDate": startDate.timeIntervalSince1970
        ]
    }
}

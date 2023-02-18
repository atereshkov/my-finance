import Foundation

public struct SavingsDVO: Equatable, Identifiable, Hashable {
    public var id: String
    public var name: String
    public var currency: String

    public var startValue: Double
    public var currentValue: Double

    public var startDate: Date

    public init(id: String, name: String) {
        self.id = id
        self.name = ""
        self.currency = ""
        self.startValue = 0.0
        self.currentValue = 0.0
        self.startDate = Date()
    }

    public init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? ""
        self.currency = data["currency"] as? String ?? ""
        self.startValue = data["startValue"] as? Double ?? 0.0
        self.currentValue = data["currentValue"] as? Double ?? 0.0
        self.startDate = Date(timeIntervalSince1970: data["startDate"] as? Double ?? 0.0)
    }
}

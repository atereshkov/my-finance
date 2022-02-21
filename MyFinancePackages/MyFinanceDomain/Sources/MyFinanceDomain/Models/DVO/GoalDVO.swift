import Foundation

public struct GoalDVO: Equatable {
    public var id: String
    public var name: String
    public var measure: String

    public var goalValue: Double
    public var startValue: Double
    public var currentValue: Double

    public var startDate: Date
    public var endDate: Date

    public init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? ""
        self.measure = data["measure"] as? String ?? ""
        self.goalValue = data["goalValue"] as? Double ?? 0.0
        self.startValue = data["startValue"] as? Double ?? 0.0
        self.currentValue = data["currentValue"] as? Double ?? 0.0
        self.startDate = Date(timeIntervalSince1970: data["startDate"] as? Double ?? 0.0)
        self.endDate = Date(timeIntervalSince1970: data["endDate"] as? Double ?? 0.0)
    }
}

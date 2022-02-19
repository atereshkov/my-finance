import Foundation

public struct GoalDVO: Equatable {
    public var id: String
    public var name: String
    public var measure: String

    public var goalValue: String
    public var startValue: String

    public var startDate: Date
    public var endDate: Date

    public init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? ""
        self.measure = data["measure"] as? String ?? ""
        self.goalValue = data["goalValue"] as? String ?? ""
        self.startValue = data["startValue"] as? String ?? ""
        self.startDate = Date(timeIntervalSince1970: data["startDate"] as? Double ?? 0.0)
        self.endDate = Date(timeIntervalSince1970: data["endDate"] as? Double ?? 0.0)
    }
}

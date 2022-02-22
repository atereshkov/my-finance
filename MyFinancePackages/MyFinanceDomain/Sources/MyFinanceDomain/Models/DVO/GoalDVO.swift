import Foundation

public struct GoalDVO: Equatable, Identifiable {
    public var id: String
    public var name: String
    public var measure: String

    public var goalValue: Double
    public var startValue: Double
    public var currentValue: Double

    public var startDate: Date
    public var endDate: Date

    public var percentCompleted: String? {
        let completed = (currentValue - startValue) / (goalValue - startValue) * 100
        return "\(Int(completed.rounded(.down)))%"
    }

    public var progressValue: Double {
        return (currentValue - startValue) / (goalValue - startValue)
    }

    public init(id: String, name: String) {
        self.id = id
        self.name = ""
        self.measure = ""
        self.goalValue = 0.0
        self.startValue = 0.0
        self.currentValue = 0.0
        self.startDate = Date()
        self.endDate = Date()
    }

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

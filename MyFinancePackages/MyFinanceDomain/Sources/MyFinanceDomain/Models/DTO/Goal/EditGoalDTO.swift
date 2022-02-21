import Foundation

public struct EditGoalDTO {
    var name: String
    var measure: String

    var goalValue: Double
    var startValue: Double

    var startDate: Date
    var endDate: Date

    public init(_ data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.measure = data["measure"] as? String ?? ""
        self.goalValue = data["goalValue"] as? Double ?? 0.0
        self.startValue = data["startValue"] as? Double ?? 0.0
        self.startDate = data["startDate"] as? Date ?? Date()
        self.endDate = data["endDate"] as? Date ?? Date()
    }

    public func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "measure": measure,
            "goalValue": goalValue,
            "startValue": startValue,
            "startDate": startDate.timeIntervalSince1970,
            "endDate": endDate.timeIntervalSince1970
        ]
    }
}

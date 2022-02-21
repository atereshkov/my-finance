import Foundation

public struct EditGoalDTO {
    var name: String
    var measure: String

    var goalValue: String
    var startValue: String

    var startDate: Date
    var endDate: Date

    public init(_ data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.measure = data["measure"] as? String ?? ""
        self.goalValue = data["goalValue"] as? String ?? ""
        self.startValue = data["startValue"] as? String ?? ""
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

import Foundation

public struct GoalDTO {
    var id: String
    var name: String
    var measure: String
    
    var goalValue: String
    var startValue: String
    var currentValue: String

    var startDate: Double
    var endDate: Double

    public init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? ""
        self.measure = data["measure"] as? String ?? ""
        self.goalValue = data["goalValue"] as? String ?? ""
        self.startValue = data["startValue"] as? String ?? ""
        self.currentValue = data["currentValue"] as? String ?? ""
        self.startDate = data["startDate"] as? Double ?? 0
        self.endDate = data["endDate"] as? Double ?? 0
    }

    public func toDictionary() -> [String: Any] {
        return [
            "name": name
        ]
    }
}

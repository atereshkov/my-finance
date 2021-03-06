import Foundation

public struct GoalDTO {
    var id: String
    var name: String
    var measure: String
    
    var goalValue: Double
    var startValue: Double
    var currentValue: Double

    var startDate: Double
    var endDate: Double

    public init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? ""
        self.measure = data["measure"] as? String ?? ""
        self.goalValue = data["goalValue"] as? Double ?? 0.0
        self.startValue = data["startValue"] as? Double ?? 0.0
        self.currentValue = data["currentValue"] as? Double ?? 0.0
        self.startDate = data["startDate"] as? Double ?? 0
        self.endDate = data["endDate"] as? Double ?? 0
    }
}

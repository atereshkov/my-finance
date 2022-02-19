import Foundation

public struct GoalDTO {
    var name: String
    var measure: String
    
    var goalValue: String
    var startValue: String

    var startDate: Date
    var endDate: Date

    public init(name: String) {
        self.name = name
        self.measure = ""
        self.goalValue = ""
        self.startValue = ""
        self.startDate = Date()
        self.endDate = Date()
    }

    public func toDictionary() -> [String: Any] {
        return [
            "name": name
        ]
    }
}

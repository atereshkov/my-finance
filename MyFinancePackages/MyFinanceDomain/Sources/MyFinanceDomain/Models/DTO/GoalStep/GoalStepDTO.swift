import Foundation

public struct GoalStepDTO {
    var id: String

    var date: Double
    var isAdd: Bool
    var value: String

    public init(id: String, data: [String: Any]) {
        self.id = id
        self.date = data["date"] as? Double ?? 0
        self.isAdd = data["isAdd"] as? Bool ?? false
        self.value = data["value"] as? String ?? ""
    }
}

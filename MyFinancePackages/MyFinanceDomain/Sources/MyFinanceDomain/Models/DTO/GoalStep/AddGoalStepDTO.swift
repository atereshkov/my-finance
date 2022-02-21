import Foundation

public struct AddGoalStepDTO {
    var value: String
    var isAdd: Bool
    var date: Date

    public init(_ data: [String: Any]) {
        self.value = data["value"] as? String ?? ""
        self.isAdd = data["isAdd"] as? Bool ?? false
        self.date = data["date"] as? Date ?? Date()
    }

    public func toDictionary() -> [String: Any] {
        return [
            "value": value,
            "isAdd": isAdd,
            "date": date.timeIntervalSince1970
        ]
    }
}

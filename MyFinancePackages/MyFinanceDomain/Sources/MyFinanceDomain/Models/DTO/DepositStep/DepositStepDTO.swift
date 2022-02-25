import Foundation

public struct DepositStepDTO {
    var id: String

    var date: Double
    var isAdd: Bool
    var value: Double

    public init(id: String, data: [String: Any]) {
        self.id = id
        self.date = data["date"] as? Double ?? 0
        self.isAdd = data["isAdd"] as? Bool ?? false
        self.value = data["value"] as? Double ?? 0.0
    }
}

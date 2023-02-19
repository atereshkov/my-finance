import Foundation

public struct SavingsTransactionDTO {
    public var id: String

    public var date: Double
    public var isAdd: Bool
    public var value: Double

    public init(id: String, data: [String: Any]) {
        self.id = id
        self.date = data["date"] as? Double ?? 0
        self.isAdd = data["isAdd"] as? Bool ?? false
        self.value = data["value"] as? Double ?? 0.0
    }
}

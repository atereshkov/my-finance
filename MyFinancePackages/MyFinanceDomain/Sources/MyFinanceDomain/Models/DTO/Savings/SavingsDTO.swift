import Foundation

public struct SavingsDTO {
    var id: String
    var name: String
    var description: String

    var currentValues: [String: Double]

    var startDate: Double

    public init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.currentValues = data["currentValues"] as? [String:Double] ?? [:]
        self.startDate = data["startDate"] as? Double ?? 0
    }
}

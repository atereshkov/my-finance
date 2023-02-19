import Foundation

public struct EditSavingsDTO {
    var name: String
    var description: String

    var currentValues: [[String: Double]]

    var startDate: Date

    public init(_ data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.currentValues = data["currentValue"] as? [[String: Double]] ?? [[:]]
        self.startDate = data["startDate"] as? Date ?? Date()
    }

    public func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "description": description,
            "currentValues": currentValues,
            "startDate": startDate.timeIntervalSince1970
        ]
    }
}

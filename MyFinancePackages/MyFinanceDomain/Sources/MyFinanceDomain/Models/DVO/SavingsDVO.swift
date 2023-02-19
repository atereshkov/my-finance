import Foundation

public struct SavingsDVO: Equatable, Identifiable, Hashable {
    public var id: String
    public var name: String
    public var description: String

    public var currentValues: [String: Double]

    public var startDate: Date

    public init(id: String, name: String) {
        self.id = id
        self.name = ""
        self.description = ""
        self.currentValues = [:]
        self.startDate = Date()
    }

    public init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.currentValues = data["currentValues"] as? [String:Double] ?? [:]
        self.startDate = Date(timeIntervalSince1970: data["startDate"] as? Double ?? 0.0)
    }
}

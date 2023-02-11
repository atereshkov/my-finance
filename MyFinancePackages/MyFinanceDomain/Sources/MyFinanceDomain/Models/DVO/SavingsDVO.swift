import Foundation

public struct SavingsDVO: Equatable, Identifiable {
    public var id: String
    public var name: String

    public init(id: String, name: String) {
        self.id = id
        self.name = ""
    }

    public init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? ""
    }
}

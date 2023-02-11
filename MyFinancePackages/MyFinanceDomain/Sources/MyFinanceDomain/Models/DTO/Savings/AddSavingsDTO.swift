import Foundation

public struct AddSavingsDTO {
    var name: String

    public init(_ data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
    }

    public func toDictionary() -> [String: Any] {
        return [
            "name": name
        ]
    }
}

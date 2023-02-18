import Foundation

public struct SavingsStepDVO: Equatable, Identifiable {
    public var id: String

    public var date: Date
    public var isAdd: Bool
    public var value: Double

    public init(id: String, data: [String: Any]) {
        self.id = id
        self.date = Date(timeIntervalSince1970: data["date"] as? Double ?? 0.0)
        self.isAdd = data["isAdd"] as? Bool ?? false
        self.value = data["value"] as? Double ?? 0.0
    }

    public init(_ dto: SavingsStepDTO) {
        self.id = dto.id
        self.date = Date(timeIntervalSince1970: dto.date)
        self.isAdd = dto.isAdd
        self.value = dto.value
    }
}

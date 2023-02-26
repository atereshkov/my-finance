import Foundation

public struct SavingsTransactionDVO: Equatable, Identifiable {
    public var id: String

    public var date: Date
    public var isAdd: Bool
    public var value: Double
    public var currency: String

    public init(id: String, data: [String: Any]) {
        self.id = id
        self.date = Date(timeIntervalSince1970: data["date"] as? Double ?? 0.0)
        self.isAdd = data["isAdd"] as? Bool ?? false
        self.value = data["value"] as? Double ?? 0.0
        self.currency = data["currency"] as? String ?? ""
    }

    public init(_ dto: SavingsTransactionDTO) {
        self.id = dto.id
        self.date = Date(timeIntervalSince1970: dto.date)
        self.isAdd = dto.isAdd
        self.value = dto.value
        self.currency = dto.currency
    }
}

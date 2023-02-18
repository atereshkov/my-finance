import Foundation

public struct DepositDTO {
    var id: String
    var bankName: String
    var name: String
    var currency: String
    var payout: String

    var rate: Double
    var tax: Double
    var startValue: Double
    var balance: Double

    var isRevocable: Bool
    var isCapitalizable: Bool
    var isReplenishable: Bool

    var startDate: Double
    var endDate: Double
    var topUpEndDate: Double

    public init(id: String, data: [String: Any]) {
        self.id = id
        self.bankName = data["bankName"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.currency = data["currency"] as? String ?? ""
        self.payout = data["payout"] as? String ?? ""
        self.rate = data["rate"] as? Double ?? 0.0
        self.tax = data["tax"] as? Double ?? 0.0
        self.startValue = data["startValue"] as? Double ?? 0.0
        self.balance = data["balance"] as? Double ?? 0.0
        self.isRevocable = data["isRevocable"] as? Bool ?? false
        self.isCapitalizable = data["isCapitalizable"] as? Bool ?? false
        self.isReplenishable = data["isReplenishable"] as? Bool ?? false
        self.startDate = data["startDate"] as? Double ?? 0
        self.endDate = data["endDate"] as? Double ?? 0
        self.topUpEndDate = data["topUpEndDate"] as? Double ?? 0
    }
}

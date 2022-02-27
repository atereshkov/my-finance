import Foundation

public struct EditDepositDTO {
    var bankName: String
    var name: String
    var currency: String
    var payout: String

    var rate: Double
    var tax: Double
    var startValue: Double

    var isRevocable: Bool
    var isCapitalizable: Bool

    var startDate: Date
    var endDate: Date
    var topUpEndDate: Date

    public init(_ data: [String: Any]) {
        self.bankName = data["bankName"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.currency = data["currency"] as? String ?? ""
        self.payout = data["payout"] as? String ?? ""
        self.rate = data["rate"] as? Double ?? 0.0
        self.tax = data["tax"] as? Double ?? 0.0
        self.startValue = data["startValue"] as? Double ?? 0.0
        self.isRevocable = data["isRevocable"] as? Bool ?? false
        self.isCapitalizable = data["isCapitalizable"] as? Bool ?? false
        self.startDate = data["startDate"] as? Date ?? Date()
        self.endDate = data["endDate"] as? Date ?? Date()
        self.topUpEndDate = data["topUpEndDate"] as? Date ?? Date()
    }

    public func toDictionary() -> [String: Any] {
        return [
            "bankName": bankName,
            "name": name,
            "currency": currency,
            "payout": payout,
            "rate": rate,
            "tax": tax,
            "startValue": startValue,
            "isRevocable": isRevocable,
            "isCapitalizable": isCapitalizable,
            "startDate": startDate.timeIntervalSince1970,
            "endDate": endDate.timeIntervalSince1970,
            "topUpEndDate": topUpEndDate.timeIntervalSince1970
        ]
    }
}

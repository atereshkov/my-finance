import Foundation

public struct DepositDVO: Equatable, Identifiable, Hashable {
    public var id: String
    public var bankName: String
    public var name: String
    public var currency: String
    public var payout: String

    public var rate: Double
    public var tax: Double
    public var startValue: Double
    public var balance: Double

    public var isRevocable: Bool
    public var isCapitalizable: Bool
    public var isReplenishable: Bool

    public var startDate: Date
    public var endDate: Date
    public var topUpEndDate: Date

    public init(id: String, name: String) {
        self.id = id
        self.bankName = ""
        self.name = ""
        self.currency = ""
        self.payout = ""
        self.rate = 0.0
        self.tax = 0.0
        self.startValue = 0.0
        self.balance = 0.0
        self.isRevocable = false
        self.isCapitalizable = false
        self.isReplenishable = false
        self.startDate = Date()
        self.endDate = Date()
        self.topUpEndDate = Date()
    }

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
        self.startDate = Date(timeIntervalSince1970: data["startDate"] as? Double ?? 0.0)
        self.endDate = Date(timeIntervalSince1970: data["endDate"] as? Double ?? 0.0)
        self.topUpEndDate = Date(timeIntervalSince1970: data["topUpEndDate"] as? Double ?? 0.0)
    }
}

public extension DepositDVO {

    var income: Double {
        let monthlyPaid = balance * rate / 100 / 12
        let months = Calendar.current.dateComponents([.month], from: startDate, to: endDate).month ?? 0
        return monthlyPaid * Double(months)
    }

    var taxValue: Double {
        return income * tax / 100
    }

    var incomeWithoutTaxes: Double {
        return income - taxValue
    }

}

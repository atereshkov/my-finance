import Foundation

import MyFinanceDomain

struct GoalStepViewItem: Identifiable {
    public var id: String

    var date: Date
    var isAdd: Bool
    var value: String

    // TODO extract to extension
    var friendlyDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }

    init(_ dvo: GoalStepDVO) {
        self.id = dvo.id
        self.isAdd = dvo.isAdd
        self.date = dvo.date
        self.value = dvo.value
    }
}

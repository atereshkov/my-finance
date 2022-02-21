import Foundation

import MyFinanceDomain

struct GoalsViewItem: Identifiable {
    let id: String
    let name: String
    let measure: String

    let goalValue: Double
    let startValue: Double
    let currentValue: Double

    let startDate: Date
    let endDate: Date

    // TODO extract to extension
    var friendlyStartDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: startDate)
    }

    var friendlyEndDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: endDate)
    }

    var percentCompleted: String? {
        let completed = currentValue / goalValue * 100
        return "\(Int(completed.rounded(.down)))%"
    }

    init(id: String, name: String) {
        self.id = id
        self.name = name
        self.measure = ""
        self.startValue = 0
        self.goalValue = 0
        self.currentValue = 0
        self.startDate = Date()
        self.endDate = Date()
    }

    init(_ dvo: GoalDVO) {
        self.id = dvo.id
        self.name = dvo.name
        self.measure = dvo.measure
        self.goalValue = dvo.goalValue
        self.currentValue = dvo.currentValue
        self.startValue = dvo.startValue
        self.startDate = dvo.startDate
        self.endDate = dvo.endDate
    }
}

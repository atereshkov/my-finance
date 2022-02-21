import Foundation

import MyFinanceDomain

struct GoalsViewItem: Identifiable {
    let id: String
    let name: String
    let measure: String

    let goalValue: String
    let startValue: String
    let currentValue: String

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
        guard let goal = Double(goalValue) else { return nil }
        guard let current = Double(currentValue) else { return nil }
        let completed = current / goal * 100
        return "\(Int(completed.rounded(.down)))%"
    }

    init(id: String, name: String) {
        self.id = id
        self.name = name
        self.measure = ""
        self.startValue = ""
        self.goalValue = ""
        self.currentValue = ""
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

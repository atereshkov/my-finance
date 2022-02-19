import Foundation

import MyFinanceDomain

struct GoalsViewItem: Identifiable {
    let id: String
    let name: String

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }

    init(_ dvo: GoalDVO) {
        self.id = dvo.id
        self.name = dvo.name
    }
}

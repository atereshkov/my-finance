import Foundation
import MyFinanceDomain

struct GoalsListRouting: Equatable {

    // MARK: - Sheet
    var showModalSheet: Bool = false
    var currentModalSheet: GoalsListSheetType?

    // MARK: - Goal Details

    var path: [GoalDVO] = []

    mutating func show(sheet: GoalsListSheetType) {
        self.currentModalSheet = sheet
        self.showModalSheet = true
    }

}

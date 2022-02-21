import Foundation

struct GoalDetailsRouting {

    // MARK: - Sheet
    var showModalSheet: Bool = false
    var currentModalSheet: GoalDetailsModalRouting?

    mutating func show(_ sheet: GoalDetailsModalRouting) {
        self.currentModalSheet = sheet
        self.showModalSheet = true
    }
}

import Foundation

struct GoalDetailsRouting {

    // MARK: Sheet
    var showModalSheet: Bool = false
    var currentModalSheet: GoalDetailsSheetType?

    // MARK: Alert
    var showAlert: Bool = false
    var currentAlert: GoalDetailsAlertType?

    mutating func show(sheet: GoalDetailsSheetType) {
        self.currentModalSheet = sheet
        self.showModalSheet = true
    }

    mutating func show(alert: GoalDetailsAlertType) {
        self.currentAlert = alert
        self.showAlert = true
    }
}

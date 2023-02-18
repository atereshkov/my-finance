import Foundation

struct SavingsDetailsRouting {

    // MARK: Sheet
    var showModalSheet: Bool = false
    var currentModalSheet: SavingsDetailsSheetType?

    // MARK: Alert
    var showAlert: Bool = false
    var currentAlert: SavingsDetailsAlertType?

    mutating func show(sheet: SavingsDetailsSheetType) {
        self.currentModalSheet = sheet
        self.showModalSheet = true
    }

    mutating func show(alert: SavingsDetailsAlertType) {
        self.currentAlert = alert
        self.showAlert = true
    }
}

import Foundation

struct SavingsStepDetailsRouting {

    // MARK: Sheet
    var showModalSheet: Bool = false
    var currentModalSheet: SavingsStepDetailsSheetType?

    // MARK: Alert
    var showAlert: Bool = false
    var currentAlert: SavingsStepDetailsAlertType?

    mutating func show(sheet: SavingsStepDetailsSheetType) {
        self.currentModalSheet = sheet
        self.showModalSheet = true
    }

    mutating func show(alert: SavingsStepDetailsAlertType) {
        self.currentAlert = alert
        self.showAlert = true
    }
}

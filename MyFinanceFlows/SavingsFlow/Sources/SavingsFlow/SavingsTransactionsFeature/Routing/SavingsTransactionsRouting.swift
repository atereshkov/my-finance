import Foundation

struct SavingsTransactionsRouting {

    // MARK: Sheet
    var showModalSheet: Bool = false
    var currentModalSheet: SavingsTransactionsSheetType?

    // MARK: Alert
    var showAlert: Bool = false
    var currentAlert: SavingsTransactionsAlertType?

    mutating func show(sheet: SavingsTransactionsSheetType) {
        self.currentModalSheet = sheet
        self.showModalSheet = true
    }

    mutating func show(alert: SavingsTransactionsAlertType) {
        self.currentAlert = alert
        self.showAlert = true
    }
}

import Foundation

struct DepositDetailsRouting {

    // MARK: Sheet
    var showModalSheet: Bool = false
    var currentModalSheet: DepositDetailsSheetType?

    // MARK: Alert
    var showAlert: Bool = false
    var currentAlert: DepositDetailsAlertType?

    mutating func show(sheet: DepositDetailsSheetType) {
        self.currentModalSheet = sheet
        self.showModalSheet = true
    }

    mutating func show(alert: DepositDetailsAlertType) {
        self.currentAlert = alert
        self.showAlert = true
    }
}

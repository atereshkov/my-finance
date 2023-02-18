import Foundation
import MyFinanceDomain

struct SavingsListRouting: Equatable {

    // MARK: - Sheet
    var showModalSheet: Bool = false
    var currentModalSheet: SavingsListSheetType?

    // MARK: - Savings Details

    var path: [SavingsDVO] = []

    mutating func show(sheet: SavingsListSheetType) {
        self.currentModalSheet = sheet
        self.showModalSheet = true
    }

}

import Foundation

struct SavingsListRouting: Equatable {

    // MARK: - Sheet
    var showModalSheet: Bool = false
    var currentModalSheet: SavingsListSheetType?

    // MARK: - Savings Details

    /// Savings ID to navigate
    var savingsDetails: String?

    mutating func show(sheet: SavingsListSheetType) {
        self.currentModalSheet = sheet
        self.showModalSheet = true
    }

}

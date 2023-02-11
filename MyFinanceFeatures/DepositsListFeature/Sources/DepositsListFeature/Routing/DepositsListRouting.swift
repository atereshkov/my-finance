import Foundation
import MyFinanceDomain

struct DepositsListRouting: Equatable {

    var showModalSheet: Bool = false
    var currentModalSheet: DepositsListSheetType?

    var path: [SavingsDVO] = []

    mutating func show(sheet: DepositsListSheetType) {
        self.currentModalSheet = sheet
        self.showModalSheet = true
    }

}

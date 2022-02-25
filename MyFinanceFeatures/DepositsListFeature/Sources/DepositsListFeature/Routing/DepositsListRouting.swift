import Foundation

struct DepositsListRouting: Equatable {

    var showModalSheet: Bool = false
    var currentModalSheet: DepositsListSheetType?

    var depositDetails: String?

    mutating func show(sheet: DepositsListSheetType) {
        self.currentModalSheet = sheet
        self.showModalSheet = true
    }

}

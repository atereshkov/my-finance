import Foundation

struct GoalsListRouting: Equatable {

    // MARK: - Sheet
    var showModalSheet: Bool = false
    var currentModalSheet: GoalsListSheetType?

    // MARK: - Goal Details

    /// Goals ID to navigate
    var goalsDetails: String?

    mutating func show(sheet: GoalsListSheetType) {
        self.currentModalSheet = sheet
        self.showModalSheet = true
    }

}

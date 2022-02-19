import Foundation

struct GoalsListRouting: Equatable {

    // MARK: - Sheet
    var showModalSheet: Bool = false
    var currentModalSheet: GoalsListModalRoutingType?

    // MARK: - Goal Details

    /// Goals ID to navigate
    var goalsDetails: String?

    mutating func show(_ sheet: GoalsListModalRoutingType) {
        self.currentModalSheet = sheet
        self.showModalSheet = true
    }

}

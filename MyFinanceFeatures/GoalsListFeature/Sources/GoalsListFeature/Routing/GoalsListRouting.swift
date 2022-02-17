import Foundation

struct GoalsListRouting: Equatable {

    // MARK: - Sheet
    var showModalSheet: Bool = false
    var currentModalSheet: HomeModalRoutingType?

    // MARK: - Book Details

    /// Goals ID to navigate
    var goalsDetails: String?

}

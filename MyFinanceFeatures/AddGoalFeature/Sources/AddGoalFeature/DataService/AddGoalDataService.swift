import Foundation
import Combine

import AppState
import Repositories
import MyFinanceDomain

public protocol AddGoalDataServiceType {
    func addGoal(data: [String: Any]) async throws
}

public class AddGoalDataService: AddGoalDataServiceType {

    private let appState: Store<AppState>
    private let goalRepository: GoalRepository

    public init(appState: Store<AppState>, goalRepository: GoalRepository) {
        self.appState = appState
        self.goalRepository = goalRepository
    }

    public func addGoal(data: [String: Any]) async throws {
        // TODO return error instead
        let userId = appState[\.user.id]!

        let goal = AddGoalDTO(data)
        try await goalRepository.addGoal(goal, userId: userId)
    }

}

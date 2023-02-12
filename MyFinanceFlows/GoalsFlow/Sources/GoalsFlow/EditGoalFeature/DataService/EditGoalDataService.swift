import Foundation
import Combine

import AppState
import Repositories
import MyFinanceDomain

public protocol EditGoalDataServiceType {
    func editGoal(id: String, data: [String: Any]) async throws
}

public class EditGoalDataService: EditGoalDataServiceType {

    private let appState: Store<AppState>
    private let goalRepository: GoalRepository

    public init(appState: Store<AppState>, goalRepository: GoalRepository) {
        self.appState = appState
        self.goalRepository = goalRepository
    }

    public func editGoal(id: String, data: [String: Any]) async throws {
        // TODO return error instead
        let userId = appState[\.user.id]!
        let goal = EditGoalDTO(data)
        try await goalRepository.editGoal(id: id, goal, userId: userId)
    }

}

import Foundation
import Combine

import AppState
import Repositories
import MyFinanceDomain

public protocol AddGoalStepDataServiceType {
    func addGoalStep(goalId: String, data: [String: Any]) async throws
}

public class AddGoalStepDataService: AddGoalStepDataServiceType {

    private let appState: Store<AppState>
    private let goalStepRepository: GoalStepRepository
    private let goalRepository: GoalRepository

    public init(
        appState: Store<AppState>,
        goalStepRepository: GoalStepRepository,
        goalRepository: GoalRepository
    ) {
        self.appState = appState
        self.goalStepRepository = goalStepRepository
        self.goalRepository = goalRepository
    }

    public func addGoalStep(goalId: String, data: [String: Any]) async throws {
        // TODO throw error instead
        let userId = appState[\.user.id]!

        let step = AddGoalStepDTO(data)

        try await goalStepRepository.addGoalStep(step, goalId: goalId, userId: userId)
        try await goalRepository.updateCurrentValue(id: goalId, value: step.value, isAdd: step.isAdd, userId: userId)
    }

}

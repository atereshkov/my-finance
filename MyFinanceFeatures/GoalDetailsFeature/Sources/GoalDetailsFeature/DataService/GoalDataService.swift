import Combine

import AppState
import MyFinanceDomain
import Repositories

public protocol GoalDataServiceType {
    func getGoalSteps(goalId: String) async throws -> [GoalStepDVO]
    func deleteGoalStep(stepId: String, value: Double, goalId: String) async throws
}

public class GoalDataService: GoalDataServiceType {

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

    public func getGoalSteps(goalId: String) async throws -> [GoalStepDVO] {
        // TODO return error instead
        let userId = appState[\.user.id]!

        let dto = try await goalStepRepository.getGoalSteps(goalId, userId: userId)

        return dto
            .compactMap { GoalStepDVO($0) }
            .sorted(by: { $0.date > $1.date })
    }

    public func deleteGoalStep(stepId: String, value: Double, goalId: String) async throws {
        let userId = appState[\.user.id]!

        try await goalStepRepository.deleteGoalStep(id: stepId, goalId: goalId, userId: userId)
        try await goalRepository.updateCurrentValue(id: goalId, value: value, isAdd: false, userId: userId)
    }

}

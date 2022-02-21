import Foundation
import Combine

import AppState
import Repositories
import MyFinanceDomain

public protocol AddGoalStepDataServiceType {
    func addGoalStep(goalId: String, data: [String: Any]) -> Future<Void, Error>
}

public class AddGoalStepDataService: AddGoalStepDataServiceType {

    private let appState: Store<AppState>
    private let goalStepRepository: GoalStepRepository

    public init(
        appState: Store<AppState>,
        goalStepRepository: GoalStepRepository
    ) {
        self.appState = appState
        self.goalStepRepository = goalStepRepository
    }

    public func addGoalStep(goalId: String, data: [String: Any]) -> Future<Void, Error> {
        // TODO return error instead
        let userId = appState[\.user.id]!

        let goalStep = AddGoalStepDTO(data)
        return goalStepRepository.addGoalStep(goalStep, goalId: goalId, userId: userId)
    }

}

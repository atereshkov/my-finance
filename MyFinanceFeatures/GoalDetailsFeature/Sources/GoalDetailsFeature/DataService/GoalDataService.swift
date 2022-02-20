import Combine

import AppState
import MyFinanceDomain
import Repositories

/*
public protocol AddGoalDataServiceType {
    func getGoal(id: String) -> Future<GoalDVO, Error>
}

public class AddGoalDataService: AddGoalDataServiceType {

    private let appState: Store<AppState>
    private let goalRepository: GoalRepository

    public init(appState: Store<AppState>, goalRepository: GoalRepository) {
        self.appState = appState
        self.goalRepository = goalRepository
    }

    public func getGoal(id: String) -> Future<GoalDVO, Error> {
        // TODO return error instead
        let userId = appState[\.user.id]!
        return goalRepository
            .getGoal(id, userId: userId)
            .map { GoalDVO() }
    }

}
*/

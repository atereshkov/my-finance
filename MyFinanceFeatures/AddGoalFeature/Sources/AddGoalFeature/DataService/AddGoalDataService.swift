import Foundation
import Combine

import AppState
import Repositories
import MyFinanceDomain

public protocol AddGoalDataServiceType {
    func addGoal(name: String) -> Future<Void, Error>
}

public class AddGoalDataService: AddGoalDataServiceType {

    private let appState: Store<AppState>
    private let goalRepository: GoalRepository

    public init(appState: Store<AppState>, goalRepository: GoalRepository) {
        self.appState = appState
        self.goalRepository = goalRepository
    }

    public func addGoal(name: String) -> Future<Void, Error> {
        // TODO return error instead
        let userId = appState[\.user.id]!

        // TODO GoalDTO -> AddGoalDTO
        let goal = GoalDTO(name: name)
        return goalRepository.addGoal(goal, userId: userId)
//        return Future { promise in
//            promise(.success(()))
//        }
    }

}

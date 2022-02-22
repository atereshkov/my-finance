import Combine

import AppState
import MyFinanceDomain
import Repositories

public protocol GoalDataServiceType {
    func getGoalSteps(goalId: String) -> Future<[GoalStepDVO], Error>
    func deleteGoalStep(stepId: String, value: Double, goalId: String) async throws
}

public class GoalDataService: GoalDataServiceType {

    private var cancellables: Set<AnyCancellable> = []

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

    public func getGoalSteps(goalId: String) -> Future<[GoalStepDVO], Error> {
        // TODO return error instead
        let userId = appState[\.user.id]!

        return Future<[GoalStepDVO], Error> { [weak self] resolve in
            guard let self = self else { return }
            self.goalStepRepository.getGoalSteps(goalId, userId: userId).sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    resolve(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { dto in
                let dvo = dto
                    .compactMap { GoalStepDVO($0) }
                    .sorted(by: { $0.date > $1.date })
                resolve(.success((dvo)))
            })
            .store(in: &self.cancellables)
        }
    }

    public func deleteGoalStep(stepId: String, value: Double, goalId: String) async throws {
        let userId = appState[\.user.id]!

        try await goalStepRepository.deleteGoalStep(id: stepId, goalId: goalId, userId: userId)
        try await goalRepository.updateCurrentValue(id: goalId, value: value, isAdd: false, userId: userId)
    }

}

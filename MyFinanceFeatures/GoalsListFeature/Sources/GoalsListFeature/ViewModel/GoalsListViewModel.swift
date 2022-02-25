import Foundation
import Combine

import AppState
import MyFinanceDomain

public class GoalsListViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    // MARK: Output

    @Published var goals: [GoalDVO] = []
    @Published var routingState = GoalsListRouting()

    public init(appState: Store<AppState>) {
        appState.map(\.data.goals)
            .sink { [weak self] data in
                self?.goals = data
            }
            .store(in: &cancellables)
    }

    func addGoalAction() {
        routingState.show(sheet: .addGoal)
    }

}

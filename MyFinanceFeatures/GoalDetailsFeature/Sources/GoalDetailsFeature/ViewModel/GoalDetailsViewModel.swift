import Foundation
import Combine

import AppState
import MyFinanceDomain

public class GoalDetailsViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    @Published var goal: GoalDVO?

    // MARK: Output

    @Published var id: String
    @Published var routingState = GoalDetailsRouting()

    @Published var goalMeasure: String = ""
    @Published var goalValue: String = ""
    @Published var startValue: String = ""
    @Published var currentValue: String = ""

    public init(
        id: String,
        appState: Store<AppState>
    ) {
        self.id = id

        appState.map(\.data.goals)
            .compactMap { $0 }
            .sink { [weak self] goals in
                self?.goal = goals.first(where: { $0.id == id })
            }
            .store(in: &cancellables)

        $goal
            .compactMap { $0 }
            .sink { [weak self] goal in
                self?.goalMeasure = goal.measure
                self?.goalValue = goal.goalValue
                self?.startValue = goal.startValue
                self?.currentValue = goal.currentValue
            }
            .store(in: &cancellables)
    }

    func editGoalAction() {
        routingState.show(.editGoal)
    }

    func addStepGoalAction() {
        routingState.show(.addGoalStep)
    }

}

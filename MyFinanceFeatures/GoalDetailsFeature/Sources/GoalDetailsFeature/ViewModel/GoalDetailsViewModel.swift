import Foundation
import Combine

import AppState
import MyFinanceDomain

public class GoalDetailsViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    private let dataService: GoalDataServiceType

    @Published private var goal: GoalDVO?

    // MARK: Output

    @Published var id: String
    @Published var routingState = GoalDetailsRouting()

    @Published var goalMeasure: String = ""
    @Published var goalValue: String = ""
    @Published var startValue: String = ""
    @Published var currentValue: String = ""
    @Published var startDate: String = ""
    @Published var endDate: String = ""

    @Published var progressValue: Double = 0.0
    @Published var percentCompletedValue: Int = 0

    @Published var steps: [GoalStepViewItem] = []

    public init(
        id: String,
        appState: Store<AppState>,
        dataService: GoalDataServiceType
    ) {
        self.id = id
        self.dataService = dataService

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
                self?.goalValue = String(goal.goalValue)
                self?.startValue = String(goal.startValue)
                self?.currentValue = String(goal.currentValue)

                // TODO extract to extension
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                self?.startDate = formatter.string(from: goal.startDate)
                self?.endDate = formatter.string(from: goal.endDate)

                let goalInt = Double(goal.goalValue)
                let currentInt = Double(goal.currentValue)
                self?.progressValue = currentInt / goalInt

                let completed = currentInt / goalInt * 100
                self?.percentCompletedValue = Int(completed.rounded(.down))
            }
            .store(in: &cancellables)

        dataService
            .getGoalSteps(goalId: id)
            .sink(receiveCompletion: { _ in

            }, receiveValue: { [weak self] dvo in
                self?.steps = dvo.map { GoalStepViewItem($0) }
            })
            .store(in: &cancellables)
    }

    func editGoalAction() {
        routingState.show(.editGoal(id))
    }

    func addStepGoalAction() {
        routingState.show(.addGoalStep(id))
    }

    func editStepAction(_ item: GoalStepViewItem) {

    }

    func deleteStepAction(_ item: GoalStepViewItem) {

    }

}

import Foundation
import Combine

import AppState
import MyFinanceDomain

public class GoalDetailsViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let dataService: GoalDataServiceType

    @Published private var id: String
    @Published private var goal: GoalDVO?

    // MARK: Output

    @Published var routingState = GoalDetailsRouting()

    @Published var goalName: String = ""
    @Published var goalMeasure: String = ""
    @Published var goalValue: String = ""
    @Published var startValue: String = ""
    @Published var currentValue: String = ""
    @Published var startDate: String = ""
    @Published var endDate: String = ""

    @Published var progressValue: Double = 0.0
    @Published var percentCompletedValue: Int = 0

    @Published var averagePerMonth: String = ""
    @Published var topUpMonthly: String = ""

    @Published var steps: [GoalStepDVO] = []

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
                self?.bind(goal)
            }
            .store(in: &cancellables)
    }

    func onAppear() {
        Task {
            await loadSteps()
        }
    }

}

extension GoalDetailsViewModel {

    func editGoalAction() {
        routingState.show(sheet: .editGoal(id))
    }

    func addStepGoalAction() {
        routingState.show(sheet: .addGoalStep(id))
    }

    func editStepAction(_ item: GoalStepDVO) {
        routingState.show(sheet: .editGoalStep(item, id))
    }

    func deleteStepAction(_ item: GoalStepDVO) {
        routingState.show(alert: .confirmDeleteStep(item))
    }

    func deleteStepActionConfirmed(_ item: GoalStepDVO) async {
        do {
            try await dataService.deleteGoalStep(stepId: item.id, value: item.value, goalId: id)
        } catch let error {
            Swift.print(error)
        }
    }

}

private extension GoalDetailsViewModel {

    private func loadSteps() async {
        do {
            let steps = try await dataService.getGoalSteps(goalId: id)
            DispatchQueue.main.async {
                self.steps = steps
            }
        } catch let error {
            Swift.print(error)
        }
    }

    private func bind(_ goal: GoalDVO) {
        bindDetails(goal)
        bindStats(goal)
    }

    private func bindDetails(_ goal: GoalDVO) {
        goalName = goal.name
        goalMeasure = goal.measure
        goalValue = goal.goalValue.formattedAsCurrency() ?? ""
        startValue = goal.startValue.formattedAsCurrency() ?? ""
        currentValue = goal.currentValue.formattedAsCurrency() ?? ""
        startDate = goal.startDate.formatted(date: .numeric, time: .omitted)
        endDate = goal.endDate.formatted(date: .numeric, time: .omitted)

        if goal.goalValue - goal.startValue > 0 {
            progressValue = (goal.currentValue - goal.startValue) / (goal.goalValue - goal.startValue)

            let completed = (goal.currentValue - goal.startValue) / (goal.goalValue - goal.startValue) * 100
            percentCompletedValue = Int(completed.rounded(.down))
        }
    }

    private func bindStats(_ goal: GoalDVO) {
        let monthsTotal = Calendar.current.dateComponents([.month], from: goal.startDate, to: goal.endDate).month ?? 0
        let monthsLeft = Calendar.current.dateComponents([.month], from: Date(), to: goal.endDate).month ?? 0

        averagePerMonth = ((goal.currentValue - goal.startValue) / (Double(monthsTotal) - Double(monthsLeft))).rounded().formattedAsCurrency() ?? ""

        topUpMonthly = ((goal.goalValue - goal.currentValue) / Double(monthsLeft)).rounded().formattedAsCurrency() ?? ""
    }

}

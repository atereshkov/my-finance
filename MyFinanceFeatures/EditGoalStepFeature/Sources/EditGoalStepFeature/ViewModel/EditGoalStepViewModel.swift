import Foundation
import Combine

import MyFinanceDomain

public class EditGoalStepViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let dataService: EditGoalStepDataServiceType

    private var step: GoalStepDVO
    private let goalId: String

    // MARK: Input

    @Published var amount: String?
    @Published var isAdd: Bool = true
    @Published var date = Date()

    // MARK: Output

    @Published var routingState = EditGoalStepRouting()
    @Published var state: EditGoalStepViewState = .start

    // MARK: - Lifecycle

    public init(
        step: GoalStepDVO,
        goalId: String,
        dataService: EditGoalStepDataServiceType
    ) {
        self.step = step
        self.goalId = goalId
        self.dataService = dataService

        self.amount = String(step.value)
        self.isAdd = step.isAdd
        self.date = step.date
    }

    deinit {
        Swift.print("[Deinit] EditGoalStepViewModel")
    }

}

// MARK: - Internal

extension EditGoalStepViewModel {

    func editGoalStepAction() async {
        let data: [String: Any] = [
            "value": Double(amount ?? "") ?? 0.0,
            "isAdd": isAdd,
            "date": date
        ]

        do {
            try await dataService.editGoalStep(id: step.id, goalId: goalId, data: data)
        } catch let error {
            Swift.print(error)
        }
    }

    func onAppear() {
        routingState.isPresented = true
    }

    func onDisappear() {
        routingState.isPresented = false
        cancellables.removeAll()
    }

}

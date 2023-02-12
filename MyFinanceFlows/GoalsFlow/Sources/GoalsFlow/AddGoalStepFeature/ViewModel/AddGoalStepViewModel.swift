import Foundation
import Combine

public class AddGoalStepViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let dataService: AddGoalStepDataServiceType

    private let goalId: String

    // MARK: Input

    @Published var amount: String?
    @Published var isAdd: Bool = true
    @Published var date = Date()

    // MARK: Output

    @Published var routingState = AddGoalStepRouting()
    @Published var state: AddGoalStepViewState = .start

    // MARK: - Lifecycle

    public init(
        id: String,
        dataService: AddGoalStepDataServiceType
    ) {
        self.goalId = id
        self.dataService = dataService
    }

    deinit {
        Swift.print("[Deinit] AddGoalStepViewModel")
    }

}

// MARK: - Internal

extension AddGoalStepViewModel {

    func addGoalStepAction() async {
        let data: [String: Any] = [
            "value": Double(amount ?? "") ?? 0.0,
            "isAdd": isAdd,
            "date": date
        ]

        do {
            try await dataService.addGoalStep(goalId: goalId, data: data)
            Swift.print("add goal step finish")
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

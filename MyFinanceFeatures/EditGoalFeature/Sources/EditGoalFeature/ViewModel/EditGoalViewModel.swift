import Foundation
import Combine

import AppState
import MyFinanceDomain

public class EditGoalViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let id: String
    private let dataService: EditGoalDataServiceType

    // MARK: Input

    @Published var name: String?
    @Published var goalValue: String?
    @Published var start: String?
    @Published var current: String?

    @Published var goalMeasureIndex: Int = 0
    @Published var startDate = Date()
    @Published var endDate = Date()

    // MARK: Output

    @Published var routingState = EditGoalRouting()
    @Published var state: EditGoalViewState = .start

    @Published var goalMeasureOptions = [
        GoalMeasureViewItem(id: "USD", name: "USD"),
        GoalMeasureViewItem(id: "EUR", name: "EUR"),
        GoalMeasureViewItem(id: "RUB", name: "RUB"),
        GoalMeasureViewItem(id: "BYN", name: "BYN"),
        GoalMeasureViewItem(id: "percent", name: "%")
    ]

    @Published var goal: GoalDVO?

    public init(
        id: String,
        appState: Store<AppState>,
        service: EditGoalDataServiceType
    ) {
        self.id = id
        self.dataService = service

        appState.map(\.data.goals)
            .compactMap { $0 }
            .sink { [weak self] goals in
                self?.goal = goals.first(where: { $0.id == id })
            }
            .store(in: &cancellables)

        $goal
            .compactMap { $0 }
            .sink { [weak self] goal in
                self?.name = goal.name
                self?.goalValue = String(goal.goalValue)
                self?.start = String(goal.startValue)
                self?.current = String(goal.currentValue)
                self?.startDate = goal.startDate
                self?.endDate = goal.endDate
                self?.goalMeasureIndex = self?.goalMeasureOptions.firstIndex(where: { $0.id == goal.measure }) ?? 0
            }
            .store(in: &cancellables)
    }

    func editGoalAction() {
        let data: [String: Any] = [
            "name": name ?? "",
            "measure": goalMeasureOptions[goalMeasureIndex].id,
            "goalValue": Double(goalValue ?? "") ?? 0,
            "startValue": Double(start ?? "") ?? 0,
            "startDate": startDate,
            "endDate": endDate
        ]

        dataService
            .editGoal(id: id, data: data)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    Swift.print(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                Swift.print("123123123")
                self?.onDisappear()
            })
            .store(in: &cancellables)
    }

    func onAppear() {
        routingState.isPresented = true
    }

    func onDisappear() {
        routingState.isPresented = false
        cancellables.removeAll()
    }

}

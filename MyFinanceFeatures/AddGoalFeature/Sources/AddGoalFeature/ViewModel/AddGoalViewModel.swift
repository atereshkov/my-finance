import Foundation
import Combine

import AppState

public class AddGoalViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    private let dataService: AddGoalDataServiceType

    // MARK: Input

    @Published var name: String?
    @Published var goal: String?
    @Published var start: String?
    @Published var current: String?

    @Published var goalMeasureIndex: Int = 0
    @Published var startDate = Date()
    @Published var endDate = Date()

    // MARK: Output

    @Published var routingState = AddGoalRouting()
    @Published var state: AddGoalViewState = .start

    @Published var title: String?

    @Published var goalMeasureOptions = [
        GoalMeasureViewItem(id: "USD", name: "USD"),
        GoalMeasureViewItem(id: "EUR", name: "EUR"),
        GoalMeasureViewItem(id: "RUB", name: "RUB"),
        GoalMeasureViewItem(id: "BYN", name: "BYN"),
        GoalMeasureViewItem(id: "PLN", name: "PLN"),
        GoalMeasureViewItem(id: "percent", name: "%")
    ]

    @Published var dismissAction: Bool = false

    public init(
        appState: Store<AppState>,
        service: AddGoalDataService
    ) {
        self.dataService = service

        $name
            .sink { [weak self] in self?.title = $0 ?? "New Goal" }
            .store(in: &cancellables)
    }

    func addGoalAction() async {
        let data: [String: Any] = [
            "name": name ?? "",
            "measure": goalMeasureOptions[goalMeasureIndex].id,
            "goalValue": Double(goal ?? "") ?? 0,
            "startValue": Double(start ?? "") ?? 0,
            "currentValue": Double(current ?? "") ?? 0,
            "startDate": startDate,
            "endDate": endDate
        ]

        do {
            try await dataService.addGoal(data: data)
            onDisappear()
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
        state = .dismiss
    }

    deinit {
        Swift.print("AddGoalViewModel deinit")
    }

}

import Combine

public class AddGoalViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    // MARK: Input

    @Published var name: String?
    @Published var goal: String?
    @Published var start: String?
    @Published var done: String?

    // MARK: Output

    @Published var routingState = AddGoalRouting()
    @Published var state: AddGoalViewState = .start

    @Published var title: String?

    @Published var goalMeasureOptions = [
        GoalMeasureViewItem(id: "percent", name: "%"),
        GoalMeasureViewItem(id: "USD", name: "USD"),
        GoalMeasureViewItem(id: "EUR", name: "EUR"),
        GoalMeasureViewItem(id: "RUB", name: "RUB"),
        GoalMeasureViewItem(id: "BYN", name: "BYN")
    ]

    public init() {
        $name
            .sink { [weak self] in self?.title = $0 ?? "New Goal" }
            .store(in: &cancellables)
    }

    func addGoalAction() {
        
    }

    func onAppear() {
        routingState.isPresented = true
    }

    func onDisappear() {
        routingState.isPresented = false
        cancellables.removeAll()
    }

}

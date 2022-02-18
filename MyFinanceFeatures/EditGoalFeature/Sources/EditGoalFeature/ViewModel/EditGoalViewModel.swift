import Combine

public class EditGoalViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    private let id: String

    // MARK: Input

    @Published var name: String?
    @Published var goal: String?
    @Published var start: String?
    @Published var done: String?

    // MARK: Output

    @Published var routingState = EditGoalRouting()
    @Published var state: EditGoalViewState = .start

    @Published var goalMeasureOptions = [
        GoalMeasureViewItem(id: "percent", name: "%"),
        GoalMeasureViewItem(id: "USD", name: "USD"),
        GoalMeasureViewItem(id: "EUR", name: "EUR"),
        GoalMeasureViewItem(id: "RUB", name: "RUB"),
        GoalMeasureViewItem(id: "BYN", name: "BYN")
    ]

    public init(id: String) {
        self.id = id
    }

    func editGoalAction() {
        
    }

    func onAppear() {
        routingState.isPresented = true
    }

    func onDisappear() {
        routingState.isPresented = false
        cancellables.removeAll()
    }

}

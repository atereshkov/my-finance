import Combine

public class AddGoalStepViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    private let id: String

    // MARK: Input

    @Published var amount: String?

    // MARK: Output

    @Published var routingState = AddGoalStepRouting()
    @Published var state: AddGoalStepViewState = .start

    public init(id: String) {
        self.id = id
    }

    func addGoalStepAction() {

    }

    func onAppear() {
        routingState.isPresented = true
    }

    func onDisappear() {
        routingState.isPresented = false
        cancellables.removeAll()
    }

}

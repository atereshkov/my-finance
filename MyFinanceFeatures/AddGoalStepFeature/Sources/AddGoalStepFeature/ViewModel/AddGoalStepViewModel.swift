import Combine

public class AddGoalStepViewModel: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []

    // MARK: Input

    @Published var amount: String?

    // MARK: Output

    @Published var routingState = AddGoalStepRouting()
    @Published var state: AddGoalStepViewState = .start

    public init() {

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

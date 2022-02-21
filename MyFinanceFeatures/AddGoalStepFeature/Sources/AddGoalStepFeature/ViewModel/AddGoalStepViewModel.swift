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

    public init(
        id: String,
        dataService: AddGoalStepDataServiceType
    ) {
        self.goalId = id
        self.dataService = dataService
    }

    func addGoalStepAction() {
        let data: [String: Any] = [
            "value": amount ?? "",
            "isAdd": isAdd,
            "date": date
        ]

        dataService
            .addGoalStep(goalId: goalId, data: data)
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
